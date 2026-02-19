{ config, lib, pkgs, ... }:
let
    cfg = config.custom.stylix;
in
{
    options.custom.stylix = {
        enable = lib.mkEnableOption "enable Stylix";
    };

    config = lib.mkIf cfg.enable {
        stylix = {
            enable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
            polarity = "dark";
            image = ../wallpaper.png;
            fonts = {
                serif = {
                    package = pkgs.ibm-plex;
                    name = "IBM Plex Serif";
                };
                sansSerif = {
                    package = pkgs.ibm-plex;
                    name = "IBM Plex Sans";
                };
                monospace = {
                    package = pkgs.nerd-fonts.iosevka;
                    name = "Iosevka Nerd Font";
                };
                emoji = {
                    package = pkgs.whatsapp-emoji-font;
                    name = "Apple Color Emoji";
                };
                sizes = {
                    desktop = 10;
                    popups = 10;
                    applications = 11;
                    terminal = 12;
                };
            };
            cursor = {
                package = pkgs.apple-cursor;
                name = "macOS";
                size = 24;
            };
            icons = {
                enable = true;
                package = pkgs.papirus-icon-theme;
                dark = "Papirus-Dark";
                light = "Papirus-Light";
            };
            targets = {
                gtk.enable = true;
                qt.enable = true;
                kde.enable = true;
                firefox.enable = false;
                nixvim.enable = false;
                waybar.addCss = false;
                rofi.enable = false;
            };
        };

        xdg.configFile."kdeglobals".text = ''
            [Icons]
            Theme=${config.stylix.icons.dark}
        '';

        fonts.fontconfig.enable = true;
    };
}
