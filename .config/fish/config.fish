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
set -x EDITOR "/opt/nvim.appimage"

# Useful aliases
alias ls='exa'
alias ll='exa -alh --group-directories-first --group --icons'
alias open='xdg-open'
alias editnvimrc='$EDITOR /home/davide/.config/nvim/init.vim'
alias cpclip='xclip -selection clipboard'
alias nvim='$EDITOR'
alias neovide='$HOME/src/neovide/target/release/neovide'

# Dotfiles managing
alias dotfm='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# PyEnv
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

# Java
# export JAVA_HOME="/usr/lib/jvm/jdk-15"
# export PATH="/usr/lib/jvm/jdk-15/bin:$PATH"
export JAVA_HOME="/opt/jdk-16"
export PATH="/opt/jdk-16/bin:$PATH"

# Ant
export ANT_HOME="/opt/apache-ant-1.10.12"
export PATH="/opt/apache-ant-1.10.12/bin:$PATH"

# GoBuster
export PATH="/opt/gobuster:$PATH"

# TexLive
export PATH="/usr/local/texlive/2020/bin/x86_64-linux:$PATH"

# Sets FZF command
export FZF_DEFAULT_COMMAND='fdfind --type f --no-ignore-vcs'

# If there is a virtual env source it
if set -q VIRTUAL_ENV and test -f $VIRTUAL_ENV/bin/activate.fish
  . "$VIRTUAL_ENV/bin/activate.fish"
end

# Sets default node version to latest
set --universal nvm_default_version latest

# Cargo, Rust and all of its friends
export PATH="$HOME/.cargo/bin:$PATH"

function fish_greeting
	pfetch
end
