{ config, lib, ... }:
let
    cfg = config.custom.window-manager.hyprland;
in
{
    options.custom.window-manager.hyprland = {
        enable = lib.mkEnableOption "enable Hyprland";
    };

    config = lib.mkIf cfg.enable {
        wayland.windowManager.hyprland = {
            enable = true;
            xwayland.enable = true;
            settings = {
                "$mod" = "SUPER";
                monitor = ",1920x1080@75,0x0,1";
                exec-once = [
                    "hyprpaper"
                    "waybar"
                    "nm-applet"
                    "systemctl --user start hyprpolkitagent"
                    "blueman-applet"
                ];
                input = {
                    kb_layout = "us,us";
                    kb_variant = ",intl";
                };
                general = {
                    gaps_in = 4;
                    gaps_out = 8;
                    border_size = 1;
                };
                decoration = {
                    rounding = 4;

                    blur = {
                        enabled = "yes";
                        size = 4;
                    };

                    shadow = {
                        enabled = "yes";
                    };
                };
                dwindle = {
                    pseudotile = "yes";
                    preserve_split = "yes";
                };
                misc = {
                    force_default_wallpaper = 0;
                };
                bind = [
                    "$mod SHIFT, Q, exit"
                    "$mod, Q, killactive"
                    "$mod, Return, exec, kitty"
                    "$mod, Space, exec, rofi -show"
                    "$mod, V, togglefloating"
                    "$mod, P, pseudo"
                    "$mod, J, togglesplit"

                    "$mod, left, movefocus, l"
                    "$mod, right, movefocus, r"
                    "$mod, up, movefocus, u"
                    "$mod, down, movefocus, d"

                    "$mod, S, togglespecialworkspace, magic"
                    "$mod SHIFT, S, movetoworkspace, special:magic"

                    ", Print, exec, grimblast --freeze copy area"
                    "$mod, Print, exec, grimblast copy screen"
                    "$mod SHIFT, Print, exec, grimblast copy active"

                    "$mod SHIFT, Space, exec, hyprctl switchxkblayout current next"
                ]
                ++ (
                    builtins.concatLists (builtins.genList (i:
                        let ws = i + 1;
                        in [
                            "$mod, code:1${toString i}, workspace, ${toString ws}"
                            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                        ]
                    ) 9)
                );
                bindm = [
                    "ALT, mouse:272, movewindow"
                    "ALT, mouse:273, resizewindow"
                ];
                bindl = [
                    ", XF86AudioPlay, exec, playerctl play-pause"
                    ", XF86AudioPrev, exec, playerctl prev"
                    ", XF86AudioNext, exec, playerctl next"
                    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                    ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ];
                bindle = [
                    ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%+"
                    ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%-"
                    ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
                    ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
                ];
                windowrule = [
                    "suppressevent maximize, class:.*"
                    "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
                    "float,move (monitor_w*0.5) (monitor_h*0.5),class:nm-connection-editor"
                ];
            };
        };
    };
}
