###########################################
#  _                    _             _   #
# | |    __ _ _ __ ___ | |__       _-(")- #
# | |   / _` | '_ ` _ \| '_ \    `%%%%%   #
# | |__| (_| | | | |_| | |_) | _  // \\   #
# |_____\__,_|_| |_| |_|_.__/_| |__  ___  #
#                  | |   / _` | '_ \/ __| #
#                  | |__| (_| | |_) \__ \ #
#  2024-01-12      |_____\__,_|_.__/|___/ #
###########################################

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
  # Custom pixelart
  bash ~/.config/pixelart/lamb16.sh
end

set -g -x EDITOR micro

# Dotfile repo adapter
alias gitdotfiles="/usr/bin/git --git-dir=$HOME/dotfiles-linux-public-repo --work-tree=$HOME"
alias gitprivate="/usr/bin/git --git-dir=$HOME/dotfiles-linux-private-repo --work-tree=$HOME"

# Tmuxinator helper
alias tx tmuxinator
alias tx-start ~/.config/cmd/tmuxinator-fzf-start.sh # Easy tmux session start form stored projects
