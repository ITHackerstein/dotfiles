{ config, lib, pkgs, ... }:
let
    cfg = config.custom.nix-search;
in
{
    options.custom.nix-search = {
        enable = lib.mkEnableOption "enable nix-search";
    };

    config = lib.mkIf cfg.enable {
        home.packages = [
            (pkgs.writeShellApplication
            {
                name = "ns";
                runtimeInputs = [ pkgs.fzf pkgs.nix-search-tv ];
                checkPhase = "";
                text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
            })
        ];
    };
}
