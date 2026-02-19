{ config, lib, ... }:
let
    cfg = config.custom.starship;
in
{
    options.custom.starship = {
        enable = lib.mkEnableOption "enable Starship";
    };

    config = lib.mkIf cfg.enable {
        programs.starship = {
            enable = true;
            enableFishIntegration = lib.mkIf config.custom.shell.fish.enable true;
        };
    };
}
