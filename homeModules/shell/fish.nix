{ config, lib, pkgs, ... }:
let
    cfg = config.custom.shell.fish;
in
{
    options.custom.shell.fish = {
        enable = lib.mkEnableOption "enable Fish";
    };

    config = lib.mkIf cfg.enable {
        # NOTE: Keep Bash as default shell, but convert it to Fish for interactive sessions
        programs.bash = {
            enable = true;
            enableCompletion = true;
            initExtra = ''
                if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$$ --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
                then
                    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
                    exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
                fi
            '';
        };

        programs.fish = {
            enable = true;
            generateCompletions = true;
            functions = lib.mkIf config.custom.fastfetch.enable {
                fish_greeting = "fastfetch -c examples/8.jsonc";
            };
        };
    };
}
