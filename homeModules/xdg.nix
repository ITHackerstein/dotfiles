{ config, lib, ... }:
let
    cfg = config.custom.xdg;
in
{
    options.custom.xdg = {
        enable = lib.mkEnableOption "enable XDG configuration";
    };

    config = lib.mkIf cfg.enable {
        xdg.userDirs = {
            enable = true;
            createDirectories = true;
            extraConfig = {
                XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
            };
        };
    };
}
