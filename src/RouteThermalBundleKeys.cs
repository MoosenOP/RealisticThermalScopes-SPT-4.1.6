using SPTarkov.DI.Annotations;
using SPTarkov.Server.Core.DI;
using SPTarkov.Server.Core.Models.Spt.Tables;

namespace realisticThermalScopes;

// Avoid SPT bundle-key collisions with WTT Content Backport; preserve the original scope visuals.
// It is intentionally independent of WTT's presence; no third-party files are changed.
[Injectable(TypePriority = OnLoadOrder.PostLoad + 50000)]
public sealed class RouteThermalBundleKeys(TemplateTable templates) : IOnLoad
{
    private static readonly (string Id, string Legacy, string Replacement, string Name)[] ScopeAssets =
    {
        ("5d1b5e94d7ad1a2b865a96b0", "assets/content/items/mods/scopes/scope_all_flir_rs32_225_9x_35_60hz.bundle", "assets/moosenop/realisticthermals/scopes/scope_all_flir_rs32_225_9x_35_60hz.bundle", "FLIR RS-32"),
        ("6478641c19d732620e045e17", "assets/content/items/mods/scopes/scope_all_sig_sauer_echo1_thermal_reflex_sight_1_2x_30hz.bundle", "assets/moosenop/realisticthermals/scopes/scope_all_sig_sauer_echo1_thermal_reflex_sight_1_2x_30hz.bundle", "SIG ECHO1"),
        ("609bab8b455afd752b2e6138", "assets/content/items/mods/scopes/scope_all_torrey_pines_logic_t12_w_30hz.bundle", "assets/moosenop/realisticthermals/scopes/scope_all_torrey_pines_logic_t12_w_30hz.bundle", "T12W"),
        ("63fc44e2429a8a166c7f61e6", "assets/content/items/mods/scopes/scope_base_armasight_zeus_pro_640_2_16x50_30hz.bundle", "assets/moosenop/realisticthermals/scopes/scope_base_armasight_zeus_pro_640_2_16x50_30hz.bundle", "Zeus-Pro"),
        ("67641b461c2eb66ade05dba6", "assets/content/items/mods/scopes/scope_base_ciklon_shakhin_37x.bundle", "assets/moosenop/realisticthermals/scopes/scope_base_ciklon_shakhin_37x.bundle", "Shakhin"),
        ("5a1eaa87fcdbcb001865f75e", "assets/content/items/mods/scopes/scope_base_trijicon_reap-ir.bundle", "assets/moosenop/realisticthermals/scopes/scope_base_trijicon_reap-ir.bundle", "REAP-IR"),
    };

    public Task OnLoadAsync(CancellationToken cancellationToken)
    {
        int routed = 0;
        foreach (var s in ScopeAssets)
        {
            cancellationToken.ThrowIfCancellationRequested();
            if (!templates.Items.TryGetValue(s.Id, out var item) || item.Properties?.Prefab == null)
            {
                Console.WriteLine($"[RTS 1.0.1] NOT ROUTED {s.Name}: item or Prefab unavailable. Item ID={s.Id}");
                continue;
            }
            var prefab = item.Properties.Prefab;
            var old = prefab.Path;
            if (string.Equals(old, s.Replacement, StringComparison.OrdinalIgnoreCase))
            {
                routed++;
                Console.WriteLine($"[RTS 1.0.1] Already routed {s.Name}");
                continue;
            }
            if (!string.Equals(old, s.Legacy, StringComparison.OrdinalIgnoreCase))
            {
                Console.WriteLine($"[RTS 1.0.1] NOT ROUTED {s.Name}: unexpected prefab path '{old ?? "null"}' (expected '{s.Legacy}')");
                continue;
            }
            prefab.Path = s.Replacement;
            routed++;
            Console.WriteLine($"[RTS 1.0.1] Routed {s.Name}: {old} -> {prefab.Path}");
        }
        Console.WriteLine($"[RTS 1.0.1] Routed {routed}/6 scope templates. No WTT files changed.");
        return Task.CompletedTask;
    }
}
