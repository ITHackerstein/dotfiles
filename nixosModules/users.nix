{ lib, users, ... }:
{
    users.users = lib.foldl' (acc: user:
        acc // {
            ${user} = {
                isNormalUser = true;
                extraGroups = [ "wheel" "networkmanager" ];
            };
        }
    ) {} users;
}
