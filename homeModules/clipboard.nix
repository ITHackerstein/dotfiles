{ config, lib, pkgs, ... }:
let
    cfg = config.custom.clipboard;
in
{
    options.custom.clipboard = {
        enable = lib.mkEnableOption "enable clipboard provider (wl-clipboard)";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.wl-clipboard ];
    };
}
