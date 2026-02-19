{ config, lib, pkgs, ... }:
let
    cfg = config.custom.qbittorrent;
in
{
    options.custom.qbittorrent = {
        enable = lib.mkEnableOption "enable qBittorrent";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.qbittorrent ];
    };
}
