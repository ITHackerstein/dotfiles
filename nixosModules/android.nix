{ config, lib, pkgs, ... }:
let
    cfg = config.custom.android;
in
{
    options.custom.android = {
        enable = lib.mkEnableOption "enable Android support";
    };

    config = lib.mkIf cfg.enable {
        programs.adb.enable = true;
        services.udev.packages = [
            pkgs.libmtp
        ];
    };
}
