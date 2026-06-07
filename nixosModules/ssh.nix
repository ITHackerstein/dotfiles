{ config, lib, ... }:
let
    cfg = config.custom.ssh;
in
{
    options.custom.ssh = {
        enable = lib.mkEnableOption "enable SSH";
    };

    config = lib.mkIf cfg.enable {
        services.openssh = {
            enable = true;
            startWhenNeeded = true;
            ports = [ 20000 ];
            settings = {
                PasswordAuthentication = false;
                KbdInteractiveAuthentication = false;
                PermitRootLogin = "no";
            };
        };
    };
}
