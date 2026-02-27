{ config, lib, pkgs, ... }:
let
    cfg = config.custom.microfetch;
in
{
    options.custom.microfetch = {
        enable = lib.mkEnableOption "enable microfetch";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.microfetch ];
    };
}
