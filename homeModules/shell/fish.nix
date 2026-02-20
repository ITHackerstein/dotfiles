{ config, lib, ... }:
{
    programs.fish = {
        enable = true;
        generateCompletions = true;
        functions = lib.mkIf config.custom.fastfetch.enable {
            fish_greeting = "fastfetch -c examples/8.jsonc";
        };
    };
}
