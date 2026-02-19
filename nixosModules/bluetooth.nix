{ config, lib, ... }:
let
    cfg = config.custom.bluetooth;
in
{
    options.custom.bluetooth = {
        enable = lib.mkEnableOption "enable Bluetooth";
    };

    config = lib.mkIf cfg.enable {
        hardware.bluetooth.enable = true;
        services.blueman.enable = true;
    };
}
