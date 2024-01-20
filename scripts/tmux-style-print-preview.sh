#!/bin/bash

############################################
#  _                    _             _    #
# | |    __ _ _ __ ___ | |__       _-(")-  #
# | |   / _` | '_ ` _ \| '_ \    `%%%%%    #
# | |__| (_| | | | |_| | |_) | _  // \\    #
# |_____\__,_|_| |_| |_|_.__/_| |__  ___   #
#                  | |   / _` | '_ \/ __|  #
#                  | |__| (_| | |_) \__ \  #
#  2024-01-12      |_____\__,_|_.__/|___/  #
#                                          #
############################################

printf "\ue0b8"
printf "\uf240"
printf "\u258c"
printf "\u2590"
printf "\u2599" 
printf "\u25b6"
printf "\u25c0"
printf "\u25e2"
printf "\u3010"
printf "\u3011"
printf "\uf61a"
printf "\ue1bc"

printf "\n"

# Current Tmux Style
printf "\033[48;5;7m\033[38;5;0m Kasia \033[0m"
printf "\033[48;5;2m\033[38;5;0m 1: fish \033[0m"
printf "\033[48;5;0m\033[38;5;2m 2: fish \033[0m"
printf "\033[48;5;2m\033[38;5;0m 3: fish \033[0m"
printf "\033[48;5;2m\033[38;5;0m 4: fish \033[0m"
printf "\033[48;5;2m\033[38;5;0m               \033[0m"
printf "\033[48;5;7m\033[38;5;0m 18:02 19-Jan-24 \033[0m"
printf "\n"
printf "\n"

# Current Tmux Style with space
printf "\033[48;5;7m\033[38;5;0m Kasia \033[0m"
printf "\033[48;5;2m\033[38;5;0m 1: fish  \033[0m"
printf "\033[48;5;0m\033[38;5;2m 2: fish \033[0m"
printf "\033[48;5;2m\033[38;5;0m  3: fish  \033[0m"
printf "\033[48;5;2m\033[38;5;0m  4: fish  \033[0m"
printf "\033[48;5;2m\033[38;5;0m          \033[0m"
printf "\033[48;5;7m\033[38;5;0m 18:02 19-Jan-24 \033[0m"
printf "\n"
printf "\n"

# Inverse Style
printf "\033[48;5;7m\033[38;5;0m Kasia \033[0m"
printf "\033[48;5;8m\033[38;5;7m 1: fish \033[0m"
printf "\033[48;5;2m\033[38;5;0m 2: fish \033[0m"
printf "\033[48;5;8m\033[38;5;7m 3: fish \033[0m"
printf "\033[48;5;8m\033[38;5;7m 4: fish \033[0m"
printf "\033[48;5;8m\033[38;5;7m               \033[0m"
printf "\033[48;5;7m\033[38;5;0m 18:02 19-Jan-24 \033[0m"
printf "\n"
printf "\n"

# Other
printf "\033[48;5;7m\033[38;5;0m Kasia \033[0m"
printf "\033[48;5;0m\033[38;5;7m 1: fish \033[0m"
printf "\033[48;5;2m\033[38;5;0m 2: fish \033[0m"
printf "\033[48;5;0m\033[38;5;7m 3: fish \033[0m"
printf "\033[48;5;0m\033[38;5;7m 4: fish \033[0m"
printf "\033[48;5;0m\033[38;5;7m               \033[0m"
printf "\033[48;5;7m\033[38;5;0m 18:02 19-Jan-24 \033[0m"
printf "\n"
printf "\n"

# New
printf "\033[48;5;7m\033[38;5;0m"
printf " Kasia"
printf "\033[48;5;7m\033[38;5;236m\u2590" 
#232

printf "\033[48;5;236m\033[38;5;8m\u2590" 
printf "\033[48;5;8m\033[38;5;7m1: fish"
printf "\033[48;5;8m\033[38;5;236m\u2590"

printf "\033[48;5;236m\033[38;5;2m\u2590" 
printf "\033[48;5;2m\033[38;5;0m2: fish"
printf "\033[48;5;2m\033[38;5;236m\u2590"

printf "\033[48;5;236m\033[38;5;8m\u2590" 
printf "\033[48;5;8m\033[38;5;7m3: fish"
printf "\033[48;5;8m\033[38;5;236m\u2590"

printf "\033[48;5;236m\033[38;5;8m\u2590" 
printf "\033[48;5;8m\033[38;5;7m4: fish"
printf "\033[48;5;8m\033[38;5;236m\u2590"

printf "\033[48;5;236m\033[38;5;236m               "

printf "\033[48;5;236m\033[38;5;7m\u2590"
printf "\033[48;5;7m\033[38;5;0m18:02 19-Jan-24 "
printf "\033[0m"
printf "\n"
printf "\n"

# New Custormization
#232
#236 - Pasek
belt_bg=234
#238 - Nie aktywny
card_inactive_bg=238
card_inactive_fg=7
card_active_bg=2 #22 28
card_active_fg=0
card_separator_bg=28
card_separator_fg=0
card_separator_ch=""

printf "\033[48;5;7m\033[38;5;0m"
printf " Kasia"
printf "\033[48;5;7m\033[38;5;${belt_bg}m\u2590" 

printf "\033[48;5;${belt_bg}m\033[38;5;${card_inactive_bg}m\u2590" 
printf "\033[48;5;${card_inactive_bg}m\033[38;5;${card_inactive_fg}m1: fish"
printf "\033[48;5;${card_inactive_bg}m\033[38;5;${belt_bg}m\u2590"

printf "\033[48;5;${card_separator_bg}m\033[38;5;${card_separator_fg}m${card_separator_ch}"

printf "\033[48;5;${belt_bg}m\033[38;5;${card_active_bg}m\u2590" 
printf "\033[48;5;${card_active_bg}m\033[38;5;${card_active_fg}m2: fish"
printf "\033[48;5;${card_active_bg}m\033[38;5;${belt_bg}m\u2590"

printf "\033[48;5;${card_separator_bg}m\033[38;5;${card_separator_fg}m${card_separator_ch}"

printf "\033[48;5;${belt_bg}m\033[38;5;${card_inactive_bg}m\u2590" 
printf "\033[48;5;${card_inactive_bg}m\033[38;5;${card_inactive_fg}m3: fish"
printf "\033[48;5;${card_inactive_bg}m\033[38;5;${belt_bg}m\u2590"

printf "\033[48;5;${card_separator_bg}m\033[38;5;${card_separator_fg}m${card_separator_ch}"

printf "\033[48;5;${belt_bg}m\033[38;5;${card_inactive_bg}m\u2590" 
printf "\033[48;5;${card_inactive_bg}m\033[38;5;${card_inactive_fg}m4: fish"
printf "\033[48;5;${card_inactive_bg}m\033[38;5;${belt_bg}m\u2590"

printf "\033[48;5;${belt_bg}m\033[38;5;${belt_bg}m               "

printf "\033[48;5;${belt_bg}m\033[38;5;7m\u2590"
printf "\033[48;5;7m\033[38;5;0m18:02 19-Jan-24 "
printf "\033[0m"
printf "\n"
printf "\n"

printf "\033[38;5;2m Kasia \033[0m"
