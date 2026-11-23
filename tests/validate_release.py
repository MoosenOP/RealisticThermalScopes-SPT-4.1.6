from pathlib import Path
import zipfile, json, hashlib, re
root=Path(__file__).resolve().parents[1]
manifest=json.loads((root/'assets/bundles.json').read_text(encoding='utf-8'))['manifest']
keys=[x['key'] for x in manifest]
assert len(keys)==7 and len(set(keys))==7, 'Expected seven unique bundle entries'
assert sum(k.startswith('assets/moosenop/realisticthermals/scopes/') for k in keys)==6
assert sum(k.startswith('assets/content/items/mods/tactical/') for k in keys)==1
assert not any(k.startswith('assets/content/items/mods/scopes/') for k in keys)
for k in keys:
    assert (root/'assets/bundles'/k).is_file(), k
    assert (root/'assets/bundles'/k).stat().st_size>100_000
main=(root/'source/realisticThermalScopes-lessPixelated.cs').read_text(encoding='utf-8')
route=(root/'source/RouteThermalBundleKeys.cs').read_text(encoding='utf-8')
project=(root/'source/realisticThermalScopes-lessPixelated.csproj').read_text(encoding='utf-8')
assert 'new("1.0.1")' in main and '<Version>1.0.1</Version>' in project
assert 'com.moosenop.realisticthermalscopes.port' in main
assert 'PostLoad + 50000' in route
assert '[RTS 1.0.1] Routed {routed}/6 scope templates' in route
scope_ids=['5d1b5e94d7ad1a2b865a96b0','6478641c19d732620e045e17','609bab8b455afd752b2e6138','63fc44e2429a8a166c7f61e6','67641b461c2eb66ade05dba6','5a1eaa87fcdbcb001865f75e']
for item_id in scope_ids:
    assert item_id in main and item_id in route
assert 'test01' not in (main+route+project).lower()
assert 'new("1.0.1-test01")' not in main
EXPECTED_BUNDLE_SHA256 = {'assets/moosenop/realisticthermals/scopes/scope_all_flir_rs32_225_9x_35_60hz.bundle': '05eb0205ae96a940f18002da583cd6acdb56caf0d9e1d3ca73ce970f73f7e2ed', 'assets/moosenop/realisticthermals/scopes/scope_all_sig_sauer_echo1_thermal_reflex_sight_1_2x_30hz.bundle': 'bc64ebb066574a512e2b86902d28198c74a2198ef620364181f9195414ba953d', 'assets/moosenop/realisticthermals/scopes/scope_all_torrey_pines_logic_t12_w_30hz.bundle': '710101c09b48aff4eb4bcb954be2f194eadb1f2ba3593e47ec13e19ced78fe58', 'assets/moosenop/realisticthermals/scopes/scope_base_armasight_zeus_pro_640_2_16x50_30hz.bundle': '6e447428e42a8cc62ba7777212f2c9f1204b29d156aeff0916dfb4e882f9d5c0', 'assets/moosenop/realisticthermals/scopes/scope_base_ciklon_shakhin_37x.bundle': '5348912aba36c87cfe32af5b86944fb53b2d6e1fe3e8be9b69cd9ced067be9e9', 'assets/moosenop/realisticthermals/scopes/scope_base_trijicon_reap-ir.bundle': '538d38ad2a651a0402abd1408ba7214045d759a7b34cc623e5c45aeffef463ed', 'assets/content/items/mods/tactical/tactical_mp155_kalashnikov_ultima_camera_thermal.bundle': '53ae1506b566dce32ff0cd804efe531c68a2412b13102ec55fb6a748a514033e'}
for k in keys:
    h=hashlib.sha256((root/'assets/bundles'/k).read_bytes()).hexdigest()
    assert h == EXPECTED_BUNDLE_SHA256[k], f'Bundle binary changed: {k}'
print('PASS: v1.0.1 metadata, seven unchanged Unity assets, six distinct RTS routes, and no test-only labels.')
