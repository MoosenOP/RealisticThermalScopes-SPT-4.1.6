# Changelog

## v1.0.1 — WTT Content Backport compatibility fix

- Resolved six duplicate thermal scope bundle key collisions with WTT Content Backport 2.0.7.
- Moved RTS registrations of the six enhanced thermal scope bundles under dedicated `assets/moosenop/realisticthermals/scopes/` keys.
- Updated six existing thermal scope prefab references at PostLoad to use the namespaced RTS assets.
- Kept all seven underlying Unity bundle binaries byte-for-byte unchanged from the preceding RTS release; retained the original MP-155 Ultima thermal camera bundle key.
- Retained thermal visual effects, zoom profiles, and aim sensitivity, with no item ID changes and no required WTT dependency.

Verified in Test01: SPT 4.1.6 startup with RTS and WTT Content Backport 2.0.7; no duplicate `Unable to add bundle` warnings; six scope templates routed; in-game RTS enhanced visuals confirmed. Final v1.0.1 compilation, release startup, and VirusTotal checks are required before publication.

## v1.0.0

Initial published unofficial SPT 4.1.6 compatibility port.

**Versioning note:** The project also had an unpublished GitHub draft labeled 2.0.0. This 1.0.1 update follows the published GitHub/Forge 1.0.0 version, not that draft.
