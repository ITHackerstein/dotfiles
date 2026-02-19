{ config, lib, pkgs, ... }:
let
    cfg = config.custom.spotify;
in
{
    options.custom.spotify = {
        enable = lib.mkEnableOption "enable Spotify";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.spotify ];
    };
}
