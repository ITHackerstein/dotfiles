{ config, lib, ... }:
let
    cfg = config.custom.notification-daemon.dunst;
in
{
    options.custom.notification-daemon.dunst = {
        enable = lib.mkEnableOption "enable Dunst";
    };

    config = lib.mkIf cfg.enable {
        # FIXME: Configure and customize
        services.dunst.enable = true;
    };
}
