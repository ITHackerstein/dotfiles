{ config, lib, ... }:
let
    cfg = config.custom.login-manager.ly;
in
{
    options.custom.login-manager.ly = {
        enable = lib.mkEnableOption "enable Ly login manager";
    };

    config = lib.mkIf cfg.enable {
        services.displayManager.ly = {
            enable = true;
            settings = {
                animation = "matrix";
            };
        };
    };
}
