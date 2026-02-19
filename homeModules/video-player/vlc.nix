{ config, lib, pkgs, ... }:
let
    cfg = config.custom.video-player.vlc;
in
{
    options.custom.video-player.vlc = {
        enable = lib.mkEnableOption "enable VLC";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.vlc ];
    };
}
