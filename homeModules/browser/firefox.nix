{ config, lib, ... }:
let
    cfg = config.custom.browser.firefox;
in
{
    options.custom.browser.firefox = {
        enable = lib.mkEnableOption "enable Firefox";
    };

    config = lib.mkIf cfg.enable {
        programs.firefox = {
            enable = true;
            languagePacks = [ "en-US" "it" ];
        };
    };
}
