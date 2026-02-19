{ config, lib, ... }:
let
    cfg = config.custom.gc;
in
{
    options.custom.gc = {
        enable = lib.mkEnableOption "enable garbage collection";
    };

    config = {
        nix.optimise.automatic = true;
        nix.gc = {
            automatic = true;
            dates = lib.mkDefault "weekly";
            options = lib.mkDefault "--delete-older-than 30d";
        };
    };
}
