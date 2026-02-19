{ config, lib, ... }:
let
    cfg = config.custom.terminal.kitty;
in
{
    options.custom.terminal.kitty = {
        enable = lib.mkEnableOption "enable Kitty";
    };

    config = lib.mkIf cfg.enable {
        programs.kitty = {
            enable = true;
            shellIntegration.enableFishIntegration = true;
            settings = {
                disable_ligatures = "never";
                close_on_child_death = "yes";
            };
        };
    };
}
