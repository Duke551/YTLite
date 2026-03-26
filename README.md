# YTPlus-Custom

Custom YouTube Plus IPA builder. Downloads the official pre-built [YTLite](https://github.com/dayanch96/YTLite) deb and injects it alongside selected tweaks into a decrypted YouTube IPA using [cyan](https://github.com/asdfzxcvbn/pyzule-rw).

## How it works

1. **YTLite** — Downloaded as a pre-built `.deb` from [dayanch96's releases](https://github.com/dayanch96/YTLite/releases). Not built from source (the public repo source doesn't produce a complete dylib).
2. **Other tweaks** (YouPiP, YTUHD, YTVideoOverlay, etc.) — Cloned and built from source via Theos on each run, so they're always the latest version.
3. **Injection** — Uses [cyan](https://github.com/asdfzxcvbn/pyzule-rw) (dev branch) which includes the designated requirement fix for sideloading.
4. **Output** — A ready-to-sideload IPA uploaded as a draft GitHub Release.

## Building

1. Go to **Actions** → **Create YouTube Plus app**
2. Click **Run workflow**
3. Fill in:
   - **IPA URL** — Direct download link to a decrypted YouTube IPA (21.08+)
   - **Tweak version** — YTLite version to download (default: `5.2b4`)
   - Toggle whichever extra tweaks you want (YouPiP, YTUHD, etc.)
4. Wait ~3 minutes, grab the IPA from **Releases** (draft)

## Custom changes vs upstream YTLite

| Change | Why |
|--------|-----|
| Official pre-built deb | Source build produces incomplete 226KB dylib vs 15.8MB official |
| Cyan dev branch | Fixes designated requirement for sideloaded apps |
| No duplicate deb injection | Prevents `ytplus.deb` from being added twice during injection |
| DEMC/RYD disabled by default | Both cause crashes on iOS 26.3+ |

## Automatic updates

A scheduled workflow (`check-updates.yml`) runs weekly to check for new YTLite releases. If a new version is found, it opens a PR bumping the default version. Just merge and trigger a build.

You can also run the check manually from **Actions** → **Check for YTLite Updates**.

## Sideloading

Install the IPA via [SideLoadly](https://sideloadly.io/) or your preferred method. No jailbreak required.
