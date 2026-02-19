{ config, lib, ... }:
let
    cfg = config.custom.pipewire;
in
{
    options.custom.pipewire = {
        enable = lib.mkEnableOption "enable PipeWire";
    };

    config = lib.mkIf cfg.enable {
        services.pipewire = {
            enable = true;
            pulse.enable = true;
            alsa.enable = true;
            jack.enable = true;
            wireplumber.enable = true;
        };
    };
}
