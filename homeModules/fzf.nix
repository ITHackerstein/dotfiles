{ config, lib, ... }:
let
    cfg = config.custom.fzf;
in
{
    options.custom.fzf = {
        enable = lib.mkEnableOption "enable FZF";
    };

    config = lib.mkIf cfg.enable {
        programs.fzf = {
            enable = true;
            enableFishIntegration = true;
            defaultCommand = "fd --type f --no-ignore-vcs";
        };
    };
}
