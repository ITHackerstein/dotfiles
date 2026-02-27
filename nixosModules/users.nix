{ lib, pkgs, users, ... }:
{
    programs.bash.enable = true;
    users = {
        defaultUserShell = pkgs.bash;
        users = lib.foldl' (acc: user:
            acc // {
                ${user} = {
                    isNormalUser = true;
                    extraGroups = [ "wheel" "networkmanager" ];
                    useDefaultShell = true;
                };
            }
        ) {} users;
    };
}
