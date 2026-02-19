{ config, lib, ... }:
let
    cfg = config.custom.editor.nixvim;
in
{
    imports = [
        ./options.nix
        ./plugins
    ];

    options.custom.editor.nixvim = {
        enable = lib.mkEnableOption "enable Nixvim";
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim = {
            enable = true;
            defaultEditor = true;
            luaLoader.enable = true;
        };
    };
}
