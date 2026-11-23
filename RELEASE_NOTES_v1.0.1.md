# GitHub / Forge v1.0.1 release notes (draft)

**Realistic Thermal Scopes — Less Pixelated v1.0.1 (SPT 4.1.6)**

Compatibility update for players using **WTT Content Backport**. This release eliminates six duplicate AssetBundle registration warnings by giving the six RTS thermal scope bundles independent registration keys, then assigning those assets to their original in-game thermal scopes.

- Fixed FLIR RS-32, SIG ECHO1, Torrey Pines T12W, Armasight Zeus-Pro, Cyclone Shakhin, and Trijicon REAP-IR duplicate registrations.
- Preserved FiveF's less-pixelated thermal visuals, zoom and sensitivity settings, and the MP-155 Ultima thermal camera.
- Does **not** modify WTT Content Backport files or require WTT as a dependency.
- Existing installations: remove the old RTS mod folder before extracting the v1.0.1 ZIP. Do not merge old and new bundle folders.

**SPT:** 4.1.6.  **Creator:** FiveF; unofficial port and compatibility maintenance: MoosenOP.

Before publishing: include VirusTotal links for the exact final ZIP and DLL, and update the changelog wording from 'release candidate' after the final versioned build is validated.
