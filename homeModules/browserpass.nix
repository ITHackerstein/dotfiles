{ config, lib, ... }:
let
    cfg = config.custom.browserpass;
in
{
    options.custom.browserpass = {
        enable = lib.mkEnableOption "enable Browserpass";
    };

    config = lib.mkIf cfg.enable {
        programs.browserpass = {
            enable = true;
            browsers = lib.optional config.custom.browser.firefox.enable "firefox";
        };
    };
}
