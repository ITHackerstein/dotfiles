{ config, lib, pkgs, ... }:
let
    cfg = config.custom.usb;
in
{
    options.custom.usb = {
        enable = lib.mkEnableOption "enable USB utitlies";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            usbutils
        ];
        services.udisks2.enable = true;
    };
}
