#!/usr/bin/env bash
# Check for dead links in the built site.
#
# Scans all HTML files in dist/ for external URLs and verifies
# they return a successful HTTP status code.
#
# - 2xx/3xx: OK
# - 401/403/999: warning (many sites block bots)
# - 404/5xx/000: error
#
# Usage: check-links.sh [dist-dir]
set -euo pipefail

dist="${1:-dist}"
errors=0
warnings=0
checked=0
skipped=0

# Extract all unique external URLs from built HTML files
urls=$(grep -roh \
    'href="https\?://[^"]*"\|src="https\?://[^"]*"' \
    "$dist" \
    | grep -o 'https\?://[^"]*' \
    | sort -u)

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

for url in $urls; do
    if echo "$url" | grep -qE "$skip_pattern"; then
        skipped=$((skipped + 1))
        continue
    fi

    checked=$((checked + 1))
    status=$(curl -s -o /dev/null -w "%{http_code}" \
        --max-time 10 \
        --retry 2 \
        --retry-delay 1 \
        -A "Mozilla/5.0 (compatible; link-checker/1.0)" \
        -L "$url" 2>/dev/null || echo "000")

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
done

echo ""
echo "Checked: $checked | Skipped: $skipped |" \
    "Warnings: $warnings | Errors: $errors"

if [ "$errors" -gt 0 ]; then
    echo "Found $errors dead link(s)."
    exit 1
fi

echo "All links are valid."
