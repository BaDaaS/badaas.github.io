#!/usr/bin/env bash
# Check for dead links in the built site.
#
# Scans all HTML files in dist/ for external URLs and verifies
# they return a successful HTTP status code. URL checks run in
# parallel via xargs (CHECK_LINKS_PARALLEL workers, default 16).
#
# - 2xx/3xx: OK
# - 401/403/999: warning (many sites block bots)
# - 404/5xx/000: error
#
# Usage: check-links.sh [dist-dir]
# Env:   CHECK_LINKS_PARALLEL (default 16)
set -euo pipefail

dist="${1:-dist}"
parallel="${CHECK_LINKS_PARALLEL:-16}"
start_ts=$(date +%s)

log() { printf '[%s] %s\n' "$(date +%H:%M:%S)" "$*"; }

log "check-links: dist=$dist parallel=$parallel"

if [ ! -d "$dist" ]; then
    echo "::error::Directory not found: $dist" >&2
    exit 2
fi

# Extract all unique external URLs from built HTML files
log "Scanning $dist for URLs..."
urls=$(grep -roh \
    'href="https\?://[^"]*"\|src="https\?://[^"]*"' \
    "$dist" \
    | grep -o 'https\?://[^"]*' \
    | sort -u)
total_urls=$(printf '%s\n' "$urls" | grep -c .)
log "Found $total_urls unique external URLs"

# Domains to skip:
# - CDNs and font providers (always up)
# - calendly.com (booking widget, blocks bots)
# - Own domain internal links (checked by Astro build)
skip_pattern="^https?://(fonts\.googleapis\.com\
|fonts\.gstatic\.com\
|cdn\.jsdelivr\.net\
|cdnjs\.cloudflare\.com\
|unpkg\.com\
|calendly\.com\
|badaas\.be)"

# Partition URLs into to-check and skipped
to_check=()
skipped=0
while IFS= read -r url; do
    [ -z "$url" ] && continue
    if echo "$url" | grep -qE "$skip_pattern"; then
        skipped=$((skipped + 1))
    else
        to_check+=("$url")
    fi
done <<< "$urls"

log "Checking ${#to_check[@]} URLs (skipped $skipped CDN/own-domain)"

errors=0
warnings=0
checked=0

if [ "${#to_check[@]}" -gt 0 ]; then
    log "Spawning $parallel parallel curl workers..."
    # Run curl in parallel; each worker prints "status<TAB>url".
    # The worker body is a heredoc with quoted delimiter so $url and $status
    # are passed verbatim to the worker subshell.
    worker=$(cat <<'WORKER'
url="$1"
status=$(curl -s -o /dev/null -w "%{http_code}" \
    --max-time 10 \
    --retry 2 \
    --retry-delay 1 \
    -A "Mozilla/5.0 (compatible; link-checker/1.0)" \
    -L "$url" 2>/dev/null || echo "000")
printf "%s\t%s\n" "$status" "$url"
WORKER
)
    results=$(
        printf '%s\n' "${to_check[@]}" | \
        xargs -P "$parallel" -n 1 bash -c "$worker" _
    )

    log "Workers finished, classifying results..."

    while IFS=$'\t' read -r status url; do
        [ -z "$status" ] && continue
        checked=$((checked + 1))
        if [ "$status" -ge 200 ] && [ "$status" -lt 400 ]; then
            echo "  OK ($status): $url"
        elif [ "$status" = "000" ] \
          || [ "$status" = "000000" ] \
          || [ "$status" = "401" ] \
          || [ "$status" = "403" ] \
          || [ "$status" = "999" ]; then
            echo "  WARN ($status, unreachable or bot-blocked): $url"
            warnings=$((warnings + 1))
        else
            echo "::error::Dead link: $url (HTTP $status)"
            errors=$((errors + 1))
        fi
    done <<< "$results"
fi

elapsed=$(( $(date +%s) - start_ts ))

echo ""
echo "Checked: $checked | Skipped: $skipped |" \
    "Warnings: $warnings | Errors: $errors"
log "Elapsed: ${elapsed}s"

if [ "$errors" -gt 0 ]; then
    echo "Found $errors dead link(s)."
    exit 1
fi

echo "All links are valid."
