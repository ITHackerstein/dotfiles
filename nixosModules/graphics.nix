{ config, lib, ... }:
let
    cfg = config.custom.graphics;
in
{
    options.custom.graphics = {
        enable = lib.mkEnableOption "enable graphics support";
    };

    config = lib.mkIf cfg.enable {
        hardware.graphics = {
            enable = true;
            enable32Bit = lib.mkDefault true;
        };
    };
}
