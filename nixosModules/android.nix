{ config, lib, pkgs, ... }:
let
    cfg = config.custom.android;
in
{
    options.custom.android = {
        enable = lib.mkEnableOption "enable Android support";
    };

    config = lib.mkIf cfg.enable {
        services.udev.packages = [
            pkgs.libmtp
            pkgs.android-tools
        ];
    };
}
