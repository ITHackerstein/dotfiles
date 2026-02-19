{ config, lib, pkgs, ... }:
let
    cfg = config.custom.networkmanagerapplet;
in
{
    options.custom.networkmanagerapplet = {
        enable = lib.mkEnableOption "enable nm-applet";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.networkmanagerapplet ];
    };
}
