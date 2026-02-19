{ config, lib, ... }:
let
    cfg = config.custom.git;
in
{
    options.custom.git = {
        enable = lib.mkEnableOption "enable Git";
    };

    config = lib.mkIf cfg.enable {
        programs.git = {
            enable = true;

            settings = {
                user = lib.mkDefault {
                    email = "carelladavide1@gmail.com";
                    name = "Davide Carella";
                };
                core.editor = lib.mkIf config.custom.editor.nixvim.enable "nvim";
                github.user = lib.mkDefault "ITHackerstein";
                init.defaultBranch = "main";
            };
        };
    };
}
