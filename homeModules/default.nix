{ lib, ... }:
{
    imports = [
        ./blueman-applet.nix
        ./brightnessctl.nix
        ./browser
        ./browserpass.nix
        ./clipboard.nix
        ./editor
        ./eza.nix
        ./fastfetch.nix
        ./fd.nix
        ./file-browser
        ./fonts.nix
        ./fzf.nix
        ./gh.nix
        ./git.nix
        ./grimblast.nix
        ./hyprlock.nix
        ./hyprpaper.nix
        ./hyprpolkitagent.nix
        ./kdeconnect.nix
        ./launcher
        ./networkmanagerapplet.nix
        ./notification-daemon
        ./password-store.nix
        ./playerctl.nix
        ./pwvucontrol.nix
        ./qbittorrent.nix
        ./ripgrep.nix
        ./shell
        ./spotify.nix
        ./starship.nix
        ./status-bar
        ./stylix.nix
        ./terminal
        ./video-player
        ./window-manager
        ./xdg.nix
        ./zoxide.nix
    ];

    custom.brightnessctl.enable = lib.mkDefault true;
    custom.browser.firefox.enable = lib.mkDefault true;
    custom.browserpass.enable = lib.mkDefault true;
    custom.clipboard.enable = lib.mkDefault true;
    custom.editor.nixvim.enable = lib.mkDefault true;
    custom.eza.enable = lib.mkDefault true;
    custom.fastfetch.enable = lib.mkDefault true;
    custom.file-browser.dolphin.enable = lib.mkDefault true;
    custom.git.enable = lib.mkDefault true;
    custom.grimblast.enable = lib.mkDefault true;
    custom.hyprlock.enable = lib.mkDefault true;
    custom.hyprpaper.enable = lib.mkDefault true;
    custom.kdeconnect.enable = lib.mkDefault true;
    custom.launcher.rofi.enable = lib.mkDefault true;
    custom.networkmanagerapplet.enable = lib.mkDefault true;
    custom.notification-daemon.dunst.enable = true;
    custom.password-store.enable = lib.mkDefault true;
    custom.playerctl.enable = lib.mkDefault true;
    custom.pwvucontrol.enable = lib.mkDefault true;
    custom.qbittorrent.enable = lib.mkDefault true;
    custom.spotify.enable = lib.mkDefault true;
    custom.starship.enable = lib.mkDefault true;
    custom.status-bar.waybar.enable = lib.mkDefault true;
    custom.stylix.enable = lib.mkDefault true;
    custom.terminal.kitty.enable = lib.mkDefault true;
    custom.video-player.vlc.enable = lib.mkDefault true;
    custom.window-manager.hyprland.enable = lib.mkDefault true;
    custom.xdg.enable = lib.mkDefault true;
    custom.zoxide.enable = lib.mkDefault true;
}
