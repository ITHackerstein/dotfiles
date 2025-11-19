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

# Inits Zoxide
zoxide init fish | source

# Flatpak
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
  if test -d $flatpakdir
    contains $flatpakdir $PATH; or set -a PATH $flatpakdir
  end
end

# Miasma
set -l background     222222
set -l foreground     c2c2b0
set -l selection      e4c47a
set -l comment        666666
set -l red            685742
set -l orange         b36d43
set -l yellow         c9a554
set -l green          5f875f
set -l purple         78824b
set -l sky            d7c483
set -l pink           bb7744

set -g fish_color_normal         $foreground
set -g fish_color_command        $sky
set -g fish_color_keyword        $pink
set -g fish_color_quote          $yellow
set -g fish_color_redirection    $foreground
set -g fish_color_end            $orange
set -g fish_color_error          $red
set -g fish_color_param          $purple
set -g fish_color_comment        $comment
set -g fish_color_selection      --background=$selection
set -g fish_color_search_match   --background=$selection
set -g fish_color_operator       $green
set -g fish_color_escape         $pink
set -g fish_color_autosuggestion $comment

set -g fish_pager_color_progress            $comment
set -g fish_pager_color_prefix              $sky
set -g fish_pager_color_completion          $foreground
set -g fish_pager_color_description         $comment
set -g fish_pager_color_selected_background --background=$selection

function fish_greeting
	fastfetch -c examples/8.jsonc
end
