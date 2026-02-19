{ config, lib, pkgs, ... }:
let
    cfg = config.custom.file-browser.dolphin;
in
{
    options.custom.file-browser.dolphin = {
        enable = lib.mkEnableOption "enable Dolphin";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.kdePackages.dolphin ];
    };
}
