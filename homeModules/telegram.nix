{ config, lib, pkgs, ... }:
let
    cfg = config.custom.telegram;
in
{
    options.custom.telegram = {
        enable = lib.mkEnableOption "enable Telegram";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.telegram-desktop ];
    };
}
