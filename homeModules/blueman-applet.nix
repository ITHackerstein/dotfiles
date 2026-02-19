{ lib, ... }:
{
    services.blueman-applet.enable = lib.mkDefault true;
}
