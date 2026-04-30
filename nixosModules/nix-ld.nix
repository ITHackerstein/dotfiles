{ config, lib, ... }:
let
    cfg = config.custom.nix-ld;
in
{
    options.custom.nix-ld = {
        enable = lib.mkEnableOption "enable nix-ld";
    };

    config = lib.mkIf cfg.enable {
        programs.nix-ld.enable = true;
    };
}
