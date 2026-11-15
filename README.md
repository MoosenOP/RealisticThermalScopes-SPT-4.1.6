# Realistic Thermal Scopes — Unofficial SPT 4.1.6 Port

Unofficial compatibility port of **Realistic Thermal Scopes** by **FiveF**, for **SPT 4.1.6**. This repository contains the **Less Pixelated** edition only.

**Original mod:** https://sp-mod.com/mod/2056/realistic-thermal-scopes

## Attribution and permission

Original mod and thermal asset bundles: **FiveF**. Port maintained by **MoosenOP** with permission from FiveF (as reported by the port maintainer). This is an **unofficial** port and is not presented as a release by FiveF.

The mod source declares `MIT` licensing. Before publishing this repository, include the **original full copyright/license notice** from FiveF's upstream repository or distribution; do not substitute a newly invented notice. Confirm that the granted permission covers redistributing the seven asset bundles.

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
