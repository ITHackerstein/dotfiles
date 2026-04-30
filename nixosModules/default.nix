{ lib, ... }:
{
    imports = [
        ./android.nix
        ./amdgpu.nix
        ./bluetooth.nix
        ./bootloader
        ./flatpak.nix
        ./gc.nix
        ./graphics.nix
        ./gnupg.nix
        ./input.nix
        ./kernel.nix
        ./locale.nix
        ./login-manager
        ./networkmanager.nix
        ./nix-ld.nix
        ./pipewire.nix
        ./ssh.nix
        ./steam.nix
        ./usb.nix
        ./users.nix
        ./vm.nix
        ./window-manager
    ];

    custom.android.enable = lib.mkDefault true;
    custom.bluetooth.enable = lib.mkDefault true;
    custom.bootloader.grub.enable = lib.mkDefault true;
    custom.flatpak.enable = lib.mkDefault true;
    custom.gc.enable = lib.mkDefault true;
    custom.graphics.enable = lib.mkDefault true;
    custom.gnupg.enable = lib.mkDefault true;
    custom.input.enable = lib.mkDefault true;
    custom.login-manager.ly.enable = lib.mkDefault true;
    custom.nix-ld.enable = lib.mkDefault true;
    custom.pipewire.enable = lib.mkDefault true;
    custom.ssh.enable = lib.mkDefault true;
    custom.steam.enable = lib.mkDefault true;
    custom.vm.enable = lib.mkDefault true;
    custom.usb.enable = lib.mkDefault true;
    custom.window-manager.hyprland.enable = lib.mkDefault true;
}
