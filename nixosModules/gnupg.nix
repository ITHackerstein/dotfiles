{ config, lib, ... }:
let
    cfg = config.custom.gnupg;
in
{
    options.custom.gnupg = {
        enable = lib.mkEnableOption "enable GnuPG";
    };

    config = lib.mkIf cfg.enable {
        programs.gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
        };
    };
}
