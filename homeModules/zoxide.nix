{ config, lib, ... }:
let
    cfg = config.custom.zoxide;
in
{
    options.custom.zoxide = {
        enable = lib.mkEnableOption "enable Zoxide (cd replacement)";
    };

    config = lib.mkIf cfg.enable {
        programs.zoxide = {
            enable = true;
            enableFishIntegration = true;
            options = [ "--cmd cd" ];
        };
    };
}
