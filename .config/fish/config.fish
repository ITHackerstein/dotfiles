# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/bin" ] ; then
#     PATH="$HOME/bin:$PATH"
# fi
#
# # set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/.local/bin" ] ; then
#     PATH="$HOME/.local/bin:$PATH"
# fi

# Changes the default editor
set -x EDITOR "nvim"

# Useful aliases
alias ls='exa'
alias ll='exa -alh --group-directories-first --group --icons'
alias open='xdg-open'
alias editnvimrc='$EDITOR $HOME/.config/nvim/init.vim'
alias cpclip='xclip -selection clipboard'

# Dotfiles managing
alias dotfm='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# GoBuster
# export PATH="/opt/gobuster:$PATH"

# TexLive
# export PATH="/usr/local/texlive/2020/bin/x86_64-linux:$PATH"

# Sets FZF command
export FZF_DEFAULT_COMMAND='fd --type f --no-ignore-vcs'

# Tell Flutter that we use Chromium
export CHROME_EXECUTABLE="/usr/bin/chromium"

# If there is a virtual env source it
if set -q VIRTUAL_ENV and test -f $VIRTUAL_ENV/bin/activate.fish
  . "$VIRTUAL_ENV/bin/activate.fish"
end

# Sets default node version to latest
set --universal nvm_default_version latest

# Cargo, Rust and all of its friends
set -gx PATH "$HOME/.cargo/bin" $PATH;

# .NET
set -gx PATH "$HOME/.dotnet" $PATH;
set -gx PATH "$HOME/.dotnet/tools" $PATH;

# Flatpak
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
  if test -d $flatpakdir
    contains $flatpakdir $PATH; or set -a PATH $flatpakdir
  end
end

# Lackluster
set -gx fish_color_end 7a7a7a
set -gx fish_color_error ffaa88
set -gx fish_color_quote 708090
set -gx fish_color_param aaaaaa
set -gx fish_color_option aaaaaa
set -gx fish_color_normal CCCCCC
set -gx fish_color_escape 789978
set -gx fish_color_comment 555555
set -gx fish_color_command CCCCCC
set -gx fish_color_keyword 7a7a7a
set -gx fish_color_operator 7788aa
set -gx fish_color_redirection ffaa88
set -gx fish_color_autosuggestion 2a2a2a
set -gx fish_color_selection --background=555555
set -gx fish_color_search_match --background=555555
set -gx fish_pager_color_prefix 999999
set -gx fish_pager_color_progress 555555
set -gx fish_pager_color_completion cccccc
set -gx fish_pager_color_description 7a7a7a
set -gx fish_pager_color_selected_background --background=555555

function fish_greeting
	fastfetch -c examples/8.jsonc
end
