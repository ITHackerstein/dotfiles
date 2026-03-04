{ config, lib, pkgs, ... }:
let
    cfg = config.custom.input;
in
{
    options.custom.input = {
        enable = lib.mkEnableOption "enable input drivers";
    };

    config = lib.mkIf cfg.enable {
        services.libinput.enable = true;
        environment.systemPackages = [
            pkgs.xf86_input_wacom
            pkgs.libwacom
        ];
    };
}
