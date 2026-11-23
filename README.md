# Realistic Thermal Scopes — Less Pixelated (Unofficial SPT 4.1.6 Port)

**Current release: v1.0.1**  
Original mod and thermal assets by **FiveF**. SPT 4.1.6 port and compatibility fix maintained by **MoosenOP**.

This package retains the original Less Pixelated thermal presentation and scope tuning. Version 1.0.1 resolves bundle-key collisions with **WTT Content Backport 2.0.7** (also works without WTT installed). The six enhanced thermal-scope bundles are registered under unique RTS paths and the six matching item prefab paths are redirected at startup. The MP-155 Ultima thermal-camera bundle remains on its original path.

## Changes in 1.0.1

- Fixed six `Unable to add bundle` warnings when RTS and WTT Content Backport are installed together.
- Namespaced the six scope bundle registration paths without modifying the underlying Unity bundle binaries.
- Redirected six existing scope item prefabs to the namespaced RTS bundles, leaving WTT's own registrations and files untouched.
- Preserved existing thermal visuals and zoom / aiming sensitivity tuning; no new items, balancing, or hard dependencies.

## Supported environment

- SPT **4.1.6**; C# .NET **10** for building.
- WTT Content Backport is **optional**, not a required dependency.
- Do not run two Realistic Thermal Scopes editions simultaneously under conflicting game item overrides.

## Installation (compiled player ZIP)

1. Back up the existing `SPT_Runtime/user/mods/FiveF-realisticThermalScopes_lessPixelated` folder.
2. **Delete that existing RTS mod folder entirely before installing.** Do not merge with an older build: the old bundle paths must not remain on disk.
3. Extract the ZIP at the SPT root, preserving the `SPT_Runtime/user/mods/...` hierarchy.
4. Leave WTT Content Backport unchanged. Restart the server and client; clear client cache if needed.

## Verification

With WTT Content Backport installed, the server log should report `[RTS 1.0.1] Routed 6/6 scope templates`, without the six prior `Unable to add bundle` warnings. Verify the RTS optics' enhanced thermal appearance in-game; a clean startup by itself does not prove the visual assets render correctly. Other mods may still produce unrelated warnings.

Scope templates redirected: FLIR RS-32, SIG ECHO1, Torrey Pines T12W, Armasight Zeus-Pro, Cyclone Shakhin, Trijicon REAP-IR.

## Build from source

From the source-kit folder, run PowerShell 5.1:

```powershell
.\BUILD_RELEASE.ps1 -SptRoot 'D:\SPT 4.1.6'
```

The script copies SPT runtime reference DLLs to a local `references/` folder (not redistributed), builds the DLL, and creates `RealisticThermalScopes_v1.0.1_SPT416_ReleaseCandidate.zip`. It also prints SHA-256 hashes for the ZIP and compiled DLL. The v1.0.1 player release has passed Windows compilation, startup, in-game verification, and VirusTotal checks.

## Credits and links

- FiveF — creator of Realistic Thermal Scopes and original assets. <https://sp-mod.com/mod/2056/realistic-thermal-scopes>
- FiveF source: <https://github.com/FiveFme/Realistic-Thermal-Scopes-csharp>
- MoosenOP SPT 4.1.6 port: <https://github.com/MoosenOP/RealisticThermalScopes-SPT-4.1.6>
- Port listing: <https://sp-mod.com/mod/3390/realistic-thermal-scopes-unofficial-spt-416-port>

Distributed with the original source attribution and the included license. This is an unofficial compatibility port, not an official FiveF release.


## GitHub repository asset availability

The GitHub source tree does not include the seven large Unity bundle binaries. See [BINARY_ASSETS.md](BINARY_ASSETS.md) for instructions on obtaining them from the tested release ZIP before building.
