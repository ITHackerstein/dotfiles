{ config, lib, ... }:
let
    cfg = config.custom.status-bar.waybar;
in
{
    options.custom.status-bar.waybar = {
        enable = lib.mkEnableOption "enable Waybar";
    };

    config = lib.mkIf cfg.enable {
        programs.waybar = {
            enable = true;
            style = lib.mkAfter (builtins.readFile ./style.css);
            settings = {
                mainBar = {
                    layer = "top";
                    position = "top";
                    margin-top = 8;
                    margin-left = 8;
                    margin-right = 8;
                    margin-bottom = 0;
                    spacing = 4;
                    modules-left = [
                        "group/power#power"
                        "hyprland/workspaces"
                    ];
                    modules-center = [
                        "hyprland/window"
                        "mpris"
                    ];
                    modules-right = [
                        "group/audio"
                        "backlight"
                        "battery"
                        "tray"
                        "hyprland/language"
                        "clock"
                    ];
                    "group/power#power" = {
                        orientation = "horizontal";
                        modules = [
                            "custom/power"
                            "custom/shutdown"
                            "custom/reboot"
                            "custom/logout"
                        ];
                        drawer = {
                            transition-duration = 200;
                            click-to-reveal = true;
                        };
                    };
                    "custom/power" = { "format" = "󱐥"; "tooltip" = false; };
                    "custom/shutdown" = { "format" = "󰐥"; "tooltip" = false; on-click = "shutdown now"; };
                    "custom/reboot" = { "format" = "󰜉"; "tooltip" = false; on-click = "reboot"; };
                    "custom/logout" = { "format" = "󰈆"; "tooltip" = false; on-click = "hyprctl dispatch exit"; };
                    "hyprland/workspaces" = {
                        persistent-workspaces = {
                            "*" = 9;
                        };
                    };
                    "hyprland/window" = {
                        icon = true;
                        icon-size = 18;
                        tooltip = false;
                        max-length = 32;
                        rewrite = {
                            "(.*) — Mozilla Firefox" = "Firefox - $1";
                        };
                    };
                    mpris = {
                        format = "{player_icon} {dynamic}";
                        format-paused = "{status_icon} <i>{dynamic}</i>";
                        dynamic-order = [ "title" "artist" ];
                        player-icons = {
                            spotify = "󰓇";
                            vlc = "󰎁";
                            mpv = "󰎁";
                            default = "󰝚";
                        };
                        status-icons = {
                            paused = "󰏤";
                        };
                        ignored-players = [ "firefox" ];
                        max-length = 32;
                    };
                    "group/audio" = {
                        orientation = "horizontal";
                        modules = [
                            "pulseaudio#speakers"
                            "pulseaudio#microphone"
                        ];
                    };
                    "pulseaudio#speakers" = {
                        format = "{icon}  {volume:3}%";
                        format-bluetooth = "{icon}  {volume:3}%";
                        format-icons = {
                            default = [ "" "" ];
                            default-muted = "󰝟";
                        };
                        on-scroll-up = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%+";
                        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
                        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                        on-click-middle = "pwvucontrol -t 4";
                        tooltip = false;
                    };
                    "pulseaudio#microphone" = {
                        format = "{format_source}";
                        format-source = "󰍬 {volume:3}%";
                        format-source-muted = "󰍭 {volume:3}%";
                        on-scroll-up = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 1%+";
                        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-";
                        on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
                        on-click-middle = "pwvucontrol -t 3";
                        tooltip = false;
                    };
                    backlight = {
                        device = "intel_backlight";
                        format = "󰃠 {percent:3}%";
                    };
                    battery = {
                        interval = 60;
                        format = "{icon} {capacity:3}%";
                        format-icons = {
                            default = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
                            charging = [ "󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
                        };
                    };
                    tray = {
                        icon-size = 18;
                        spacing = 4;
                    };
                    "hyprland/language" = {
                        format = "{}";
                        format-en = "🇺🇸";
                        format-en-intl = "🌍";
                        on-click = "hyprctl switchxkblayout current next";
                    };
                    clock = {
                        interval = 1;
                        tooltip = false;
                        format = "󰥔 {:%T}";
                        format-alt = "󰃭 {:%F}";
                    };
                };
            };
        };
    };
}

