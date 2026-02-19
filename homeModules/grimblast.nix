{ config, lib, pkgs, ... }:
let
    cfg = config.custom.grimblast;
in
{
    options.custom.grimblast = {
        enable = lib.mkEnableOption "enable Grimblast";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.grimblast ];
    };
}
