{ config, lib, pkgs, ... }:
let
    cfg = config.custom.pwvucontrol;
in
{
    options.custom.pwvucontrol = {
        enable = lib.mkEnableOption "enable pwvucontrol";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.pwvucontrol ];
    };
}
