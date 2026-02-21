{ config, lib, ... }:
let
    cfg = config.custom.hypridle;
in
{
    options.custom.hypridle = {
        enable = lib.mkEnableOption "enable hypridle";
    };

    config = lib.mkIf cfg.enable {
        services.hypridle = {
            enable = true;
            settings = {
                general = {
                    lock_cmd = "pidof hyprlock || hyprlock";
                    after_sleep_cmd = "hyprctl dispatch dpms on";
                };
                listener = [
                    {
                        timeout = 60 * 3;
                        on-timeout = "brightnessctl -s set 25";
                        on-resume = "brightnessctl -r";
                    }

                    {
                        timeout = 60 * 5;
                        on-timeout = "loginctl lock-session";
                    }

                    {
                        timeout = 60 * 30;
                        on-timeout = "systemctl suspend && hyprctl dispatch dpms off";
                        on-resume = "brightnessctl -r && hyprctl dispatch dpms on";
                    }
                ];
            };
        };
    };
}
