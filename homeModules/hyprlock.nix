{ config, lib, ... }:
let
    cfg = config.custom.hyprlock;
in
{
    options.custom.hyprlock = {
        enable = lib.mkEnableOption "enable hyprlock";
    };

    config = lib.mkIf cfg.enable {
        programs.hyprlock = {
            enable = true;
            settings = {
                general.ignore_empty_input = true;
                background = {
                    blur_passes = 3;
                    blur_size = 8;
                };
                input-field = {
                    font_family = config.stylix.fonts.sansSerif.name;
                    size = "360, 40";
                    outline_thickness = 2;
                    fade_on_empty = false;
                    placeholder_text = "<i>Password...</i>";
                    rounding = 4;
                };
                label = [
                    {
                        text = "<span>󰌾 </span>";
                        font_family = config.stylix.fonts.monospace.name;
                        font_size = 24;
                        position = "6, -32";
                        halign = "center";
                        valign = "top";
                        color = "${config.lib.stylix.colors.base05}";
                    }

                    {
                        text = "cmd[update:1000] date \"+%T\"";
                        font_family = config.stylix.fonts.sansSerif.name;
                        font_size = 36;
                        position = "0, -96";
                        halign = "center";
                        valign = "top";
                    }

                    {
                        text = "cmd[] date +\"%A, %F\"";
                        font_family = config.stylix.fonts.sansSerif.name;
                        font_size = 18;
                        position = "0, -164";
                        halign = "center";
                        valign = "top";
                    }

                    {
                        text = "Hi, $USER";
                        font_family = config.stylix.fonts.sansSerif.name;
                        font_size = 18;
                        position = "0, 48";
                        halign = "center";
                        valign = "center";
                    }
                ];
            };
        };
    };
}
