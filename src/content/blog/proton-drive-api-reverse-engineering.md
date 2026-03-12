---
title:
  "Syncing Logseq on Android with Proton Drive, and reverse engineering its API"
description:
  "A practical guide to syncing Logseq on Android via Termux and rclone, plus a
  deep dive into reverse engineering the undocumented Proton Drive API: SRP
  authentication, PGP key hierarchy, rate limiting, and why Proton needs a
  public API."
author: Danny Willems
draft: true
pubDate: 2026-03-11
tags:
  [
    "logseq",
    "proton-drive",
    "android",
    "termux",
    "rclone",
    "privacy",
    "sync",
    "reverse-engineering",
    "cryptography",
    "api",
  ]
---

I use [Logseq](https://logseq.com/) as my daily knowledge base. On my Linux
desktop, the graph lives in a folder synced by Proton Drive. The problem: I also
want to use Logseq on my Android phone, and Proton Drive on Android does not
expose files to the local filesystem. Other apps cannot read them.

Logseq Sync exists but is a paid service. Google Drive works but defeats the
purpose of using Proton for privacy. Syncthing requires peer-to-peer
connectivity. I wanted something simpler: pull from Proton Drive, sync to a
local folder, let Logseq read it.

The solution: Termux + rclone, running directly on the phone.

---

## What you need

- An Android phone with [Termux](https://f-droid.org/en/packages/com.termux/)
  installed from F-Droid (not the Play Store, that version is abandoned)
- A [Proton Drive](https://proton.me/drive) account with your Logseq graph
  stored in it
- [Logseq](https://f-droid.org/en/packages/com.logseq.app/) installed from
  F-Droid

---

## 1) Install rclone and cronie in Termux

Open Termux on your phone and run:

```bash
pkg update
pkg install rclone cronie termux-services
```

Grant Termux access to shared storage:

```bash
termux-setup-storage
```

A permission popup will appear. Accept it.

---

## 2) Configure rclone with Proton Drive

```bash
rclone config
```

Follow the prompts:

- Choose `n` for new remote
- Name: `protondrive`
- Type: `protondrive`
- Enter your Proton email and password
- Accept defaults for the rest

Test the connection:

```bash
rclone ls protondrive:DW/lifeos --max-depth 1 --tpslimit 2
```

If you see your files, the configuration is correct. The `--tpslimit 2` flag
prevents Proton Drive from rejecting requests with "Too many requests" errors.
If it still happens, lower it to `--tpslimit 0.5`.

---

## 3) Initial sync

rclone bisync requires a first run with `--resync` to establish the baseline:

```bash
mkdir -p ~/storage/shared/logseq-lifeos

rclone bisync protondrive:DW/lifeos ~/storage/shared/logseq-lifeos \
  --resync \
  --tpslimit 0.5 \
  --transfers 1
```

This will take a while depending on the size of your graph. The `--transfers 1`
flag processes one file at a time to avoid rate limiting from Proton.

---

## 4) Create the sync script

```bash
mkdir -p ~/logseq-sync

cat << 'EOF' > ~/logseq-sync/sync.sh
#!/data/data/com.termux/files/usr/bin/bash
LOG="$HOME/logseq-sync/sync.log"
REMOTE="protondrive:DW/lifeos"
LOCAL="$HOME/storage/shared/logseq-lifeos"

echo "$(date '+%Y-%m-%d %H:%M:%S') - sync start" >> "$LOG"

rclone bisync "$REMOTE" "$LOCAL" \
  --create-empty-src-dirs \
  --resilient \
  --tpslimit 0.5 \
  --transfers 1 \
  2>&1 | tail -5 >> "$LOG"

echo "$(date '+%Y-%m-%d %H:%M:%S') - sync done" >> "$LOG"
echo "---" >> "$LOG"
EOF

chmod +x ~/logseq-sync/sync.sh
```

---

## 5) Set up automatic sync with cron

Enable the cron daemon:

```bash
sv-enable crond
```

Edit the crontab:

```bash
crontab -e
```

Add a line to sync every 5 minutes:

```
*/5 * * * * ~/logseq-sync/sync.sh
```

---

## 6) Monitor the sync

Watch the log in real time:

```bash
tail -f ~/logseq-sync/sync.log
```

You should see entries like:

```
2026-03-11 14:30:00 - sync start
2026-03-11 14:30:12 - sync done
---
2026-03-11 14:35:00 - sync start
2026-03-11 14:35:09 - sync done
---
```

If something goes wrong, the rclone error output will appear between the start
and done lines.

---

## 7) Open the graph in Logseq

Open Logseq on your phone and select "Add a graph". Navigate to:

```
/storage/emulated/0/logseq-lifeos
```

Logseq will index the graph and you are ready to go.

---

## Tips

- **Rate limiting**: Proton Drive is aggressive with rate limits. Keep
  `--tpslimit 0.5 --transfers 1` in your sync script. It is slower but reliable.
- **Conflict handling**: rclone bisync detects conflicts. If the same file is
  modified on both sides between syncs, rclone will rename one version with a
  `.conflict` suffix. Check the log for these.
- **Battery**: cronie in Termux respects Android doze. Syncs may be delayed when
  the phone is idle. Acquire a Termux wakelock if you need consistent timing:
  `termux-wake-lock`.
- **ADB access**: you can control Termux from your PC over USB without SSH,
  avoiding open ports: `adb shell` gives you a shell on the phone.
- **Termux:Boot**: install from F-Droid to auto-start crond after a reboot.

---

## Why not other solutions?

| Solution                              | Problem                                                                |
| ------------------------------------- | ---------------------------------------------------------------------- |
| Proton Drive "Make available offline" | Files stay sandboxed in the Proton app. Other apps cannot access them. |
| Google Drive                          | Works, but you lose the privacy benefits of Proton.                    |
| Syncthing                             | Peer-to-peer only. Both devices must be online simultaneously.         |
| Logseq Sync                           | Paid service.                                                          |
| SSH/SFTP                              | Requires an open port on the phone.                                    |

rclone + Termux gives you full control, zero cost, and keeps everything on
Proton Drive.

---

## The elephant in the room: Proton Drive has no API

This setup works, but it is held together with duct tape. The reason is simple:
Proton Drive has no official public API. Everything described above relies on
reverse-engineered, undocumented endpoints. If you are a developer who wants to
integrate Proton Drive into a workflow, here is what you are actually dealing
with.

### No documentation, only reverse engineering

Proton does not publish API documentation for Drive. The endpoints live under
`mail.proton.me/api/drive/` and were discovered by reading the open-source web
client source code and intercepting network traffic. There is no OpenAPI spec,
no reference docs, no changelog for breaking changes.

The rclone protondrive backend was built entirely this way. Its author,
[henrybear327](https://github.com/henrybear327), created
[Proton-API-Bridge](https://github.com/henrybear327/Proton-API-Bridge), a Go
library that wraps these undocumented endpoints. It handles the complex
encryption handshake that every file operation requires: key exchange, signature
verification, client-side encryption and decryption. This is impressive
community work, but it is building on sand.

### Known bugs with no upstream fix

The rclone backend has known crashes. For example,
[rclone/rclone#7959](https://github.com/rclone/rclone/issues/7959) reports a nil
pointer dereference when encountering native Proton documents (Proton's own
document format). The fix has been identified but remains unmerged for over a
year. Because the backend depends on undocumented behavior, fixing bugs requires
guessing how the API is supposed to work.

### Rate limiting without rules

Proton returns HTTP 429 (Too Many Requests) responses, but publishes no rate
limit thresholds. Through empirical testing, the limit appears to be roughly
100-150 requests per minute, but this is a guess. There is no `Retry-After`
header with useful information, no documentation of per-endpoint limits, no way
to request a higher quota.

This would be manageable for a simple file storage API, but Proton Drive uses
end-to-end encryption. Every single file operation requires multiple API calls:

1. Fetch the encryption key for the folder
2. Fetch the file metadata (encrypted)
3. Download the file content (encrypted)
4. Verify the signature
5. Decrypt locally

A simple `rclone ls` on a directory with 365 files can trigger hundreds of API
calls. This is why we need `--tpslimit 0.5 --transfers 1` in the setup above:
one request every two seconds, one file at a time. Syncing a moderately sized
Logseq graph takes minutes instead of seconds.

### The community is losing patience

The rclone community is actively discussing marking the Proton Drive backend as
unsupported. Users report increasing HTTP 422 (Unprocessable Entity) errors on
uploads since September 2024, with no explanation from Proton and no way to
diagnose the issue without API documentation. When a backend cannot reliably
upload files, it is hard to call it supported.

### The SDK that is not ready

Proton released a [Drive SDK preview](https://github.com/ProtonDriveApps/sdk) in
C#. The repository explicitly states it is not ready for production use or
third-party integration. It is an internal tool that was open-sourced, not a
developer platform. There is no package on NuGet, no getting-started guide, no
issue tracker for external contributors.

In January 2026, Proton published a
[blog post about Drive SDK improvements](https://proton.me/blog/drive-sdk-january-2026)
mentioning faster and more reliable apps. But "apps" means Proton's own apps.
Third-party developers are not part of the picture.

---

## Reverse engineering the API

Since there is no documentation, the only way to understand the Proton Drive API
is to read the source code and watch the network traffic. Here is what the
community has pieced together.

### Authentication: SRP, not OAuth

Proton uses SRP (Secure Remote Password, RFC 5054) for authentication. This is
unusual. Most cloud services use OAuth 2.0. SRP is a zero-knowledge proof
protocol: the server never sees your password, not even a hash of it. The
tradeoff is that third-party apps must handle raw credentials directly.

The login flow:

1. `POST /auth/info` with the username. The server returns a salt, the SRP
   server ephemeral (`B`), the SRP session ID, and a signed modulus.
2. The client verifies the modulus signature against Proton's PGP public key.
3. The client hashes the password using bcrypt with a custom salt encoding
   (`salt + "proton"`, truncated to 16 bytes, re-encoded to bcrypt base64).
4. The hashed password is fed through Proton's custom 2048-bit hash function
   (PMHash: four concatenated SHA-512 digests with different suffixes) to
   produce the SRP private key `x`.
5. The client computes the SRP client ephemeral `A = g^a mod N` and the client
   proof `M = H(A, B, K)` where `K` is the shared session key derived from
   `S = (B - k * g^x) ^ (a + u*x) mod N`.
6. `POST /auth` with `ClientEphemeral`, `ClientProof`, and `SRPSession`. The
   server returns `AccessToken`, `RefreshToken`, `UID`, and `ServerProof`.
7. The client verifies the server proof to confirm mutual authentication.
8. Subsequent requests use `Authorization: Bearer <AccessToken>` and
   `x-pm-uid: <UID>`.

There is no OAuth 2.0 flow. In rclone, your Proton password is stored in the
config file (obfuscated, not encrypted). There is no way to use scoped tokens or
revoke access to a single app without changing your password.

### The custom hash function: PMHash

Proton does not use standard SHA-256 or SHA-512 for SRP. They use a custom
2048-bit hash called PMHash, which concatenates four SHA-512 digests:

```python
def pmhash(data):
    return (
        sha512(data + b'\x00') +
        sha512(data + b'\x01') +
        sha512(data + b'\x02') +
        sha512(data + b'\x03')
    )
```

This produces a 256-byte digest (2048 bits), matching the size of the SRP
modulus. The purpose is to avoid reducing the hash output modulo N, which could
introduce bias in the SRP computation.

### The encryption layer: PGP key hierarchy

Every file on Proton Drive is encrypted client-side with PGP. The key hierarchy
is:

1. **User key**: derived from your password, unlocks everything.
2. **Address key**: tied to your email address, signs content.
3. **Share key**: per-share encryption key, encrypted to the user key.
4. **Node key**: per-file/folder key, encrypted to the share key.
5. **Content key**: per-file-revision key, encrypted to the node key.

To read a single file, the client must:

1. Decrypt the share key using the user key.
2. Decrypt the node key using the share key.
3. Decrypt the content key using the node key.
4. Download the encrypted file blocks.
5. Decrypt each block using the content key.
6. Verify the signature using the address key.

This is why a simple directory listing triggers so many API calls. Each file
requires fetching and decrypting multiple layers of keys before you can even
read the metadata (filename, size, modification time are all encrypted).

### Key API endpoints (undocumented)

Based on the rclone source and Proton-API-Bridge, the main endpoints are:

```
POST   /auth/info                 # SRP step 1
POST   /auth                      # SRP step 2, get tokens
GET    /drive/shares              # List shares
GET    /drive/shares/{id}/links   # List files/folders in a share
GET    /drive/shares/{id}/links/{linkId}  # Get file metadata
GET    /drive/blocks/{blockId}    # Download encrypted file block
POST   /drive/shares/{id}/links   # Create file/folder
PUT    /drive/shares/{id}/links/{linkId}  # Update metadata
DELETE /drive/shares/{id}/links/{linkId}  # Delete file
```

None of these are documented. The request and response schemas were inferred
from the web client JavaScript source. Field names, required parameters, and
error codes can change without notice.

### Error codes observed in the wild

- **HTTP 429**: Too many requests. No `Retry-After` header with a useful value.
  Threshold appears to be around 100-150 requests per minute, but varies.
- **HTTP 422**: Unprocessable Entity. Increasingly common on uploads since
  September 2024. No explanation from Proton. Possibly related to signature
  validation changes on the server side.
- **HTTP 409**: Conflict. Returned when creating a file that already exists. The
  conflict resolution behavior is undocumented.
- **Nil pointer crashes in rclone**: when the API returns native Proton
  documents (a format rclone does not expect), the response parsing fails with a
  nil dereference
  ([rclone/rclone#7959](https://github.com/rclone/rclone/issues/7959)). The fix
  is known but unmerged for over a year.

### The cost of no documentation

The rclone community is actively discussing marking the Proton Drive backend as
unsupported. The combination of undocumented API changes, increasing 422 errors,
aggressive rate limiting, and the complexity of the encryption layer makes it
unsustainable for volunteer maintainers.

henrybear327's Proton-API-Bridge is the only viable Go library for Proton Drive.
It works, but every Proton web client update risks breaking it. There is no
versioned API, no deprecation policy, no way to test against a staging
environment.

---

## What Proton should publish

End-to-end encryption does not prevent publishing API documentation. The
encryption happens client-side. The server never sees plaintext. Documenting the
API endpoints, the key hierarchy, the expected request/response formats, and the
rate limits would not weaken the security model at all.

What developers need:

1. **API reference** with endpoint schemas and a changelog for breaking changes.
2. **Published rate limits** per endpoint, with proper `Retry-After` headers.
3. **OAuth 2.0 support** so third-party apps do not need to store raw
   credentials.
4. **A developer program** with an issue tracker and a point of contact for
   library maintainers who are doing Proton's ecosystem work for free.

Proton Drive is currently a consumer product. With a public API, it could be a
platform. Privacy-conscious developers want to build on it. Proton just needs to
let them.
