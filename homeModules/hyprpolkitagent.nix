{ lib, ... }:
{
    services.hyprpolkitagent.enable = lib.mkDefault true;
}
