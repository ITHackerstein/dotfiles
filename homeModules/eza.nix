{ config, lib, ... }:
let
    cfg = config.custom.eza;
in
{
    options.custom.eza = {
        enable = lib.mkEnableOption "enable eza (ls replacement)";
    };

    config = lib.mkIf cfg.enable {
        programs.eza = {
            enable = true;
            extraOptions = [ "--icons" "--group-directories-first" ];
            enableFishIntegration = true;
        };
    };
}
