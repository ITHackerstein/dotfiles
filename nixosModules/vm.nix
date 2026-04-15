{ config, lib, pkgs, ... }:
let
    cfg = config.custom.vm;
in
{
    options.custom.vm = {
        enable = lib.mkEnableOption "enable VM support";
    };

    config = lib.mkIf cfg.enable {
        virtualisation.libvirtd.enable = true;
        programs.virt-manager.enable = true;
        environment.systemPackages = [
            pkgs.dnsmasq
            pkgs.qemu
        ];
    };
}
