{ config, lib, pkgs, ... }:
let
    cfg = config.custom.window-manager.hyprland;

    battery-monitor-script = pkgs.writeShellScriptBin "battery-monitor" ''
        #!/usr/bin/env bash

        BATTERY=""
        for supply in /sys/class/power_supply/*; do
            if [ -f "$supply/type" ] && grep -q "Battery" "$supply/type"; then
                BATTERY=$(basename "$supply")
                break
            fi
        done

        if [ -z "$BATTERY" ]; then
            exit 1
        fi

        PREVIOUS_STATUS=$(cat /sys/class/power_supply/$BATTERY/status)
        SAVED_BRIGHTNESS=""
        WARNING_ID=""

        while true; do
            STATUS=$(cat /sys/class/power_supply/$BATTERY/status)
            CAPACITY=$(cat /sys/class/power_supply/$BATTERY/capacity)

            if [ "$STATUS" != "$PREVIOUS_STATUS" ]; then
                if [ "$STATUS" = "Charging" ]; then
                    SAVED_BRIGHTNESS=$(${pkgs.brightnessctl}/bin/brightnessctl get)
                    ${pkgs.brightnessctl}/bin/brightnessctl set 100%

                    if [ -n "$WARNING_ID" ]; then
                        ${pkgs.dbus}/bin/dbus-send \
                            --session \
                            --dest=org.freedesktop.Notifications \
                            --type=method_call /org/freedesktop/Notifications \
                            org.freedesktop.Notifications.CloseNotification uint32:"$WARNING_ID" 2>/dev/null

                        WARNING_ID=""
                    fi
                elif [ "$STATUS" = "Discharging" ]; then
                    if [ -n "$SAVED_BRIGHTNESS" ]; then
                        ${pkgs.brightnessctl}/bin/brightnessctl set "$SAVED_BRIGHTNESS"
                    else
                        ${pkgs.brightnessctl}/bin/brightnessctl set 30%
                    fi
                fi

                PREVIOUS_STATUS="$STATUS"
            fi

            if [ "$CAPACITY" -le 15 ] && [ "$STATUS" = "Discharging" ] && [ -z "$WARNING_ID" ]; then
                WARNING_ID=$(${pkgs.libnotify}/bin/notify-send -p -u critical "Battery Critical" "Level is at $CAPACITY%")
            fi

            sleep 2
        done
    '';
in
{
    options.custom.window-manager.hyprland = {
        enable = lib.mkEnableOption "enable Hyprland";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [
            battery-monitor-script
        ];

        wayland.windowManager.hyprland = {
            enable = true;
            xwayland.enable = true;
            configType = "lua";
            settings = {
                mod = {
                    _var = "SUPER";
                };
                monitor = {
                    output = "";
                    mode = "1920x1080@75";
                    position = "0x0";
                    scale = 1;
                };
                on = {
                    _args = [
                        "hyprland.start"
                        (lib.generators.mkLuaInline ''
                        function()
                            hl.exec_cmd("hypridle")
                            hl.exec_cmd("hyprpaper")
                            hl.exec_cmd("waybar")
                            hl.exec_cmd("nm-applet")
                            hl.exec_cmd("systemctl --user start hyprpolkitagent")
                            hl.exec_cmd("blueman-applet")
                            hl.exec_cmd("${battery-monitor-script}/bin/battery-monitor")
                        end
                        '')
                    ];
                };
                gesture = {
                    fingers = 3;
                    direction = "horizontal";
                    action = "workspace";
                };
                config = {
                    input = {
                        kb_layout = "us,us";
                        kb_variant = ",intl";

                        touchpad = {
                            tap_to_click = false;
                            natural_scroll = true;
                        };
                    };
                    general = {
                        gaps_in = 2;
                        gaps_out = 4;
                        border_size = 2;
                    };
                    decoration = {
                        rounding = 0;
                        inactive_opacity = 1.0;

                        blur = {
                            enabled = true;
                            size = 4;
                        };

                        shadow = {
                            enabled = true;
                        };
                    };
                    dwindle = {
                        preserve_split = true;
                    };
                    misc = {
                        force_default_wallpaper = 0;
                        disable_hyprland_logo = true;
                    };
                };
                bind = [
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + SHIFT + Q"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exit()'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + Q"'')
                            (lib.generators.mkLuaInline ''hl.dsp.window.close()'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + Return"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("kitty")'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + Space"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pkill rofi || rofi -emoji-mode copy -show")'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + V"'')
                            (lib.generators.mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + P"'')
                            (lib.generators.mkLuaInline ''hl.dsp.window.pseudo()'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + P"'')
                            (lib.generators.mkLuaInline ''hl.dsp.layout("togglesplit")'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + C"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pkill rofi || rofi -show calc -calc-command '${pkgs.coreutils}/bin/echo -n '{result}' | ${pkgs.wl-clipboard}/bin/wl-copy' -no-sidebar-mode -no-show-match -no-history -no-sort -hint-welcome ''' -theme-str 'listview { lines: 0; }'")'')
                        ];
                    }
                ]
                ++ (lib.concatMap
                        (direction: [
                            {
                                _args = [
                                    (lib.generators.mkLuaInline ''mod .. " + ${direction}"'')
                                    (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "${direction}" })'')
                                ];
                            }
                            {
                                _args = [
                                    (lib.generators.mkLuaInline ''mod .. " + SHIFT + ${direction}"'')
                                    (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "${direction}" })'')
                                ];
                            }
                        ])
                        [ "left" "right" "up" "down" ]
                    )
                ++ [
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + S"'')
                            (lib.generators.mkLuaInline ''hl.dsp.workspace.toggle_special("magic")'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + SHIFT + S"'')
                            (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "special:magic" })'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"Print"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("grimblast --freeze copy area")'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + Print"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("grimblast copy screen")'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + SHIFT + Print"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("grimblast copy active")'')
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''mod .. " + SHIFT + Space"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprctl switchxkblayout current next")'')
                        ];
                    }
                ]
                ++ (lib.concatMap
                    (ws: [
                        {
                            _args = [
                                (lib.generators.mkLuaInline ''mod .. " + ${toString ws}"'')
                                (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = ${toString ws} })'')
                            ];
                        }
                        {
                            _args = [
                                (lib.generators.mkLuaInline ''mod .. " + SHIFT + ${toString ws}"'')
                                (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = ${toString ws} })'')
                            ];
                        }
                    ])
                    (lib.range 1 9)
                ) ++ [
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"ALT + mouse:272"'')
                            (lib.generators.mkLuaInline ''hl.dsp.window.drag()'')
                            { mouse = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"ALT + mouse:273"'')
                            (lib.generators.mkLuaInline ''hl.dsp.window.resize()'')
                            { mouse = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"XF86AudioPlay"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl play-pause")'')
                            { locked = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"XF86AudioPrev"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl prev")'')
                            { locked = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"XF86AudioNext"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl next")'')
                            { locked = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"XF86AudioMute"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'')
                            { locked = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"XF86AudioMicMute"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")'')
                            { locked = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"switch:on:Lid Switch"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("systemctl suspend")'')
                            { locked = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"switch:off:Lid Switch"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprctl dispatch dpms on && hyprlock")'')
                            { locked = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"XF86AudioRaiseVolume"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%+")'')
                            { locked = true; repeating = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"XF86AudioLowerVolume"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%-")'')
                            { locked = true; repeating = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"XF86MonBrightnessUp"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+")'')
                            { locked = true; repeating = true; }
                        ];
                    }
                    {
                        _args = [
                            (lib.generators.mkLuaInline ''"XF86MonBrightnessDown"'')
                            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-")'')
                            { locked = true; repeating = true; }
                        ];
                    }
                ];
                window_rule = [
                    {
                        name = "fix-wayland-drags";
                        match = {
                            class = "^$";
                            title = "^$";
                            xwayland = true;
                            float = true;
                            fullscreen = false;
                            pin = false;
                        };
                        no_focus = true;
                    }
                    {
                        name = "float-nm-connection-editor";
                        match.class = "nm-connection-editor";
                        move = "monitor_w*0.5 monitor_h*0.5";
                        float = true;
                    }
                    {
                        name = "float-pwvucontrol";
                        match.class = "com.saivert.pwvucontrol";
                        move = "monitor_w*0.5 monitor_h*0.5";
                        float = true;
                    }
                    {
                        name = "float-firefox-pip";
                        match = {
                            class = "firefox";
                            title = "Picture-in-Picture";
                        };
                        float = true;
                        pin = true;
                    }
                ];
            };
        };
    };
}
