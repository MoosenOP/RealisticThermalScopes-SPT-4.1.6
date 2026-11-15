# Realistic Thermal Scopes — Unofficial SPT 4.1.6 Port

Unofficial compatibility port of **Realistic Thermal Scopes** by **FiveF**, for **SPT 4.1.6**. This repository contains the **Less Pixelated** edition only.

**Original mod:** https://sp-mod.com/mod/2056/realistic-thermal-scopes

**Original C# source:** https://github.com/FiveFme/Realistic-Thermal-Scopes-csharp

**Original TypeScript source:** https://github.com/FiveFme/realisticThermalScopes

## Attribution and permission

Realistic Thermal Scopes was originally created by **FiveF**. This is an **unofficial SPT 4.1.6 compatibility port** maintained by **MoosenOP**, published with FiveF's explicit permission conveyed through Forge messages. All original mod assets and associated credits remain attributed to FiveF. This is not an official FiveF release.

The mod source declares `MIT` licensing. FiveF mentioned a possible change to The Unlicense, but no such change is established here. The original full MIT copyright and license notice (Copyright (c) 2025 FiveF) is preserved in [LICENSE](LICENSE), copied from [FiveF's original C# repository](https://github.com/FiveFme/Realistic-Thermal-Scopes-csharp). FiveF authorized publication of the updated version; confirm the scope of asset-bundle redistribution against the original distribution terms before releasing the binary archive.

## Compatibility

- SPT **4.1.6**
- .NET **10** (for building)
- Less Pixelated edition

The distributed runtime was compared byte-for-byte against the maintainer's working serverpack archive (DLL, manifest, seven bundles). The source included here was recovered from a development checkpoint and has **not** been independently verified to rebuild the exact released DLL.

## Installation

Download the release archive and extract it into your SPT installation, preserving the included folder hierarchy. The mod should end up under `SPT_Runtime/user/mods/FiveF-realisticThermalScopes_lessPixelated/` (or the corresponding `user/mods/` folder within your SPT installation).

Do not install this port alongside another edition of Realistic Thermal Scopes using the same internal mod GUID.

## Building

The project targets `net10.0`. Its `.csproj` currently contains **local absolute paths** to SPT 4.1.6 reference assemblies (`D:\SPT 4.1.6\SPT_Runtime`); update those paths for your environment before building. Runtime asset bundles are intentionally not stored in this source repository.

## Credits

- **FiveF** — original mod and assets
- **MoosenOP** — unofficial SPT 4.1.6 compatibility port
