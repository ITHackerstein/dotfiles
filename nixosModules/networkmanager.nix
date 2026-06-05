{ lib, pkgs, ... }:
{
    networking.networkmanager = {
        enable = lib.mkDefault true;
        plugins = [ pkgs.networkmanager-openconnect ];
    };
    networking.firewall.enable = lib.mkDefault false;
}
