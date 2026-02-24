{ config, lib, pkgs, ... }:
let
    cfg = config.custom.typst;
in
{
    options.custom.typst = {
        enable = lib.mkEnableOption "enable Typst";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.typst ];
    };
}
