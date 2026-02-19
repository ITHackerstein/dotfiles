{ config, lib, pkgs, ... }:
let
    cfg = config.custom.brightnessctl;
in
{
    options.custom.brightnessctl = {
        enable = lib.mkEnableOption "enable brightnessctl";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.brightnessctl ];
    };
}
