{ config, lib, pkgs, ... }:
let
    cfg = config.custom.steam;
in
{
    options.custom.steam = {
        enable = lib.mkEnableOption "enable Steam";
    };

    config = lib.mkIf cfg.enable {
        programs.steam = {
            enable = true;
            extraCompatPackages = [ pkgs.proton-ge-bin ];
        };
    };
}
