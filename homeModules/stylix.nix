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
                    desktop = lib.mkDefault 10;
                    popups = lib.mkDefault 10;
                    applications = lib.mkDefault 11;
                    terminal = lib.mkDefault 12;
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
    };
}
