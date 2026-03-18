{ config, lib, pkgs, ... }:
let
    cfg = config.custom.notification-daemon.dunst;
in
{
    options.custom.notification-daemon.dunst = {
        enable = lib.mkEnableOption "enable Dunst";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.libnotify ];
        services.dunst.enable = true;
    };
}
