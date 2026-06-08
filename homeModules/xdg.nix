{ config, lib, pkgs, ... }:
let
    cfg = config.custom.xdg;
in
{
    options.custom.xdg = {
        enable = lib.mkEnableOption "enable XDG configuration";
    };

    config = lib.mkIf cfg.enable {
        xdg = {
            userDirs = {
                enable = true;
                createDirectories = true;
                extraConfig = {
                    SCREENSHOTS = "${config.home.homeDirectory}/Pictures/Screenshots";
                };
                setSessionVariables = true;
            };

            portal = {
                enable = true;
                extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
                config = {
                    common = {
                        default = [ "gtk" ];
                    };
                    hyprland = {
                        default = [ "gtk" "hyprland" ];
                    };
                };
            };
        };
    };
}
