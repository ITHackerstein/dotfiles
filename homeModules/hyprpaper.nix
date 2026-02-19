{ config, lib, pkgs, ... }:
let
    cfg = config.custom.hyprpaper;
in
{
    options.custom.hyprpaper = {
        enable = lib.mkEnableOption "enable Hyprpaper";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.hyprpaper ];
    };
}
