{ lib, ... }:
{
    time.timeZone = lib.mkDefault "Europe/Rome";
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
}
