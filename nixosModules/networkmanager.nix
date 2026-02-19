{ lib, ... }:
{
    networking.networkmanager.enable = lib.mkDefault true;
    networking.firewall.enable = lib.mkDefault false;
}
