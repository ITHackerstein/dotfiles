{ config, lib, pkgs, ... }:
let
    cfg = config.custom.rnote;
in
{
    options.custom.rnote = {
        enable = lib.mkEnableOption "enable rnote";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.rnote ];
    };
}
