{ config, lib, ... }:
let
    cfg = config.custom.kdeconnect;
in
{
    options.custom.kdeconnect = {
        enable = lib.mkEnableOption "enable KDE connect";
    };

    config = lib.mkIf cfg.enable {
        services.kdeconnect = {
            enable = true;
            indicator = true;
        };
    };
}
