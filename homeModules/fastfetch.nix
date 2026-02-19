{ config, lib, ... }:
let
    cfg = config.custom.fastfetch;
in
{
    options.custom.fastfetch = {
        enable = lib.mkEnableOption "enable fastfetch";
    };

    config = lib.mkIf cfg.enable {
        programs.fastfetch.enable = true;
    };
}
