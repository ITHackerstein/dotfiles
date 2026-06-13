{ pkgs, user, ... }:
{
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.11"; # Please read the comment before changing.

    home.username = user;
    home.homeDirectory = "/home/${user}";

    imports = [
        ../../../homeModules
    ];

    stylix.fonts.sizes.terminal = 14;
    wayland.windowManager.hyprland.settings.monitor = [
        {
            output = "eDP-1";
            mode = "1920x1080@60";
            position = "0x0";
            scale = 1;
        }
        {
            output = "";
            mode = "preferred";
            position = "auto";
            scale = 1;
            mirror = "eDP-1";
        }
    ];
}
