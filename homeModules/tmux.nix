{ config, lib, pkgs, ... }:
let
    cfg = config.custom.tmux;
in
{
    options.custom.tmux = {
        enable = lib.mkEnableOption "enable tmux";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.tmux ];
    };
}
