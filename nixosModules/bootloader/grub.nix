{ config, lib, ... }:
let
    cfg = config.custom.bootloader.grub;
in
{
    options.custom.bootloader.grub = {
        enable = lib.mkEnableOption "enable GRUB bootloader";
    };

    config = lib.mkIf cfg.enable {
        boot.loader.efi.canTouchEfiVariables = true;
        boot.loader.grub = {
            enable = true;
            efiSupport = true;
            useOSProber = true;
            devices = [ "nodev" ];
        };
    };
}
