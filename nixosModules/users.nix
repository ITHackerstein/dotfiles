{ lib, pkgs, users, ... }:
{
    programs.fish.enable = true;
    users = {
        defaultUserShell = pkgs.fish;
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
