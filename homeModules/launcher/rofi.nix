{ config, lib, pkgs, ... }:
let
    cfg = config.custom.launcher.rofi;
    # FIXME: Untie this from stylix if not enabled
    colors = config.lib.stylix.colors.withHashtag;
in
{
    options.custom.launcher.rofi = {
        enable = lib.mkEnableOption "enable Rofi";
    };

    config = lib.mkIf cfg.enable {
        programs.rofi = {
            enable = true;
            terminal = "${pkgs.kitty}/bin/kitty";
            modes = [ "drun" "recursivebrowser" ];
            cycle = true;
            extraConfig = {
                sidebar-mode = true;
                show-icons = true;
                icon-theme = "Papirus";
                display-drun = "󱓞  Run:";
                display-recursivebrowser = "󰉋  Files:";
            };
            theme =
            let
                inherit (config.lib.formats.rasi) mkLiteral;
            in
            {
                "*" = {
                    bg0 = mkLiteral colors.base00;
                    bg1 = mkLiteral colors.base01;
                    bg2 = mkLiteral colors.base02;
                    fg0 = mkLiteral colors.base06;
                    fg1 = mkLiteral colors.base05;
                    gray = mkLiteral colors.base04;
                    orange = mkLiteral colors.base09;
                    margin = 0;
                    padding = 0;
                    spacing = 0;
                    background-color = mkLiteral "transparent";
                };
                window = {
                    width = 500;
                    location = mkLiteral "north";
                    anchor = mkLiteral "center";
                    y-offset = mkLiteral "32px";
                    border = 1;
                    border-color = mkLiteral "@bg2";
                    border-radius = mkLiteral "0.25em";
                    background-color = mkLiteral "@bg1";
                };
                inputbar = {
                    spacing = mkLiteral "0.5em";
                    children = map mkLiteral [ "prompt" "entry" ];
                    text-color = mkLiteral "@fg1";
                    background-color = mkLiteral "@bg0";
                };
                entry = {
                    padding = mkLiteral "0.5em 0.125em";
                    text-color = mkLiteral "inherit";
                };
                prompt = {
                    padding = mkLiteral "0.5em";
                    text-color = mkLiteral "inherit";
                    background-color = mkLiteral "@orange";
                };
                "message, error-message" = {
                    padding = mkLiteral "0.5em";
                };
                message = {
                    background-color = mkLiteral "@gray";
                };
                textbox = {
                    text-color = mkLiteral "@fg1";
                };
                listview = {
                    lines = 8;
                    dynamic = false;
                    fixed-height = true;
                };
                element = {
                    padding = mkLiteral "0.5em";
                    spacing = mkLiteral "0.5em";
                    vertical-align = mkLiteral "0.5";
                    border-radius = 0;
                };
                element-icon = {
                    size = mkLiteral "1em";
                };
                element-text = {
                    text-color = mkLiteral "@fg1";
                    vertical-align = mkLiteral "0.5";
                };
                "element selected" = {
                    background-color = mkLiteral "@bg2";
                };
                mode-switcher = {
                    background-color = mkLiteral "@bg0";
                };
                button = {
                    padding = mkLiteral "0.5em";
                    text-color = mkLiteral "@fg0";
                };
                "button selected" = {
                    background-color = mkLiteral "@gray";
                };
            };
        };
    };
}
