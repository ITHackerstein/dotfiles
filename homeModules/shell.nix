{ lib, pkgs, ... }:
{
    programs.bash = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
            microfetch
            if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
                exec ${lib.getExe pkgs.tmux} new-session -A -s ssh_tmux
            fi
        '';
        shellAliases = {
            "dotfiles-edit" = "pushd ~/.dotfiles && nvim && popd";
            "dotfiles-sync" = "pushd ~/.dotfiles && git pull --rebase && git push && popd";
            "dotfiles-switch" = "home-manager switch --flake ~/.dotfiles";
            "dotfiles-system-switch" = "sudo nixos-rebuild switch --flake ~/.dotfiles && home-manager switch --flake ~/.dotfiles";
            "dotfiles-update" = "pushd ~/.dotfiles && nix flake update && sudo nixos-rebuild switch --flake . && home-manager switch --flake . && git add flake.lock && git commit -m 'Updated system' && git push && popd";
        };
    };
}
