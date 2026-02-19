{ config, lib, ... }:
let
    cfg = config.custom.window-manager.hyprland;
in
{
    options.custom.window-manager.hyprland = {
        enable = lib.mkEnableOption "enable Hyprland";
    };

    config = lib.mkIf cfg.enable {
        programs.hyprland = {
            enable = true;
            xwayland.enable = true;
        };
    };
}
