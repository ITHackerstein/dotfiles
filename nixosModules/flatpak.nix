{ config, lib, ... }:
let
    cfg = config.custom.flatpak;
in
{
    options.custom.flatpak = {
        enable = lib.mkEnableOption "enable Flatpak";
    };

    config = lib.mkIf cfg.enable {
        services.flatpak = {
            enable = true;
            packages = [
                "com.github.flxzt.rnote"
            ];
        };
    };
}
