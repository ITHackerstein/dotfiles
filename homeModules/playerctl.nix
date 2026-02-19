{ config, lib, pkgs, ... }:
let
    cfg = config.custom.playerctl;
in
{
    options.custom.playerctl = {
        enable = lib.mkEnableOption "enable playerctl";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.playerctl ];
    };
}
