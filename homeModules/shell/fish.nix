{ config, lib, ... }:
{
    programs.fish = {
        enable = true;
        generateCompletions = true;
        functions = lib.mkIf config.custom.microfetch.enable {
            fish_greeting = "microfetch";
        };
    };
}
