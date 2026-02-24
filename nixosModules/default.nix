{ lib, ... }:
{
    imports = [
        ./amdgpu.nix
        ./bluetooth.nix
        ./bootloader
        ./gc.nix
        ./graphics.nix
        ./gnupg.nix
        ./input.nix
        ./kernel.nix
        ./locale.nix
        ./login-manager
        ./networkmanager.nix
        ./pipewire.nix
        ./ssh.nix
        ./users.nix
        ./window-manager
    ];

    custom.bluetooth.enable = lib.mkDefault true;
    custom.bootloader.grub.enable = lib.mkDefault true;
    custom.gc.enable = lib.mkDefault true;
    custom.graphics.enable = lib.mkDefault true;
    custom.gnupg.enable = lib.mkDefault true;
    custom.login-manager.ly.enable = lib.mkDefault true;
    custom.pipewire.enable = lib.mkDefault true;
    custom.ssh.enable = lib.mkDefault true;
    custom.window-manager.hyprland.enable = lib.mkDefault true;
}
