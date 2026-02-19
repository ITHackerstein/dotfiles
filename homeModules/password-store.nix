{ config, lib, pkgs, ... }:
let
    cfg = config.custom.password-store;
in
{
    options.custom.password-store = {
        enable = lib.mkEnableOption "enable zx2c4's pass";
    };

    config = lib.mkIf cfg.enable {
        programs.password-store = {
            enable = true;
            package = pkgs.pass-wayland;
            settings = {
                PASSWORD_STORE_DIR = "$HOME/.password-store";
            };
        };
    };
}
