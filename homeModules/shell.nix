{ config, lib, ... }:
{
    programs.bash = {
        enable = true;
        enableCompletion = true;
        initExtra = lib.mkIf config.custom.microfetch.enable "microfetch";
    };
}
