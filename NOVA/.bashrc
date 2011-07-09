# Check for an interactive session
[ -z "$PS1" ] && return

#Main User Bash
#PS1='[\A]\[$(tput setaf 4)\]\[$(tput bold 1)\][\u@\h]\[$(tput sgr0)\]\[$(tput setaf 2)\][\w]$ \[$(tput sgr0)\]'

# Main User Cyan
PS1='[\A]\[$(tput setaf 6)\]\[$(tput bold 1)\][\u@\h]\[$(tput sgr0)\]\[$(tput setaf 6)\][\w]$ \[$(tput sgr0)\]'

# Main User Magenta
#PS1='[\A]\[$(tput setaf 5)\]\[[\u@\h]\[$(tput sgr0)\]\[$(tput bold 1)\]\[$(tput setaf 4)\][\w]$ \[$(tput sgr0)\]'

#Main Root Bash
#PS1='[\A]\[$(tput setaf 1)\]\[$(tput bold 1)\][\u@\h]\[$(tput sgr0)\]\[$(tput setaf 2)\][\w]$ \[$(tput sgr0)\]'

#Default Editor is VIM
export EDITOR="vim"

#Set GIT Directory Variable
export GITDIR="/home/burchettm/.git/computers"
export GIT="/home/burchettm/.git"

#Set ScreenShots Directory Variable
export SCREENSHOTS="/home/burchettm/Desktop/Screenshots"

#Enable LIBETC (dotfiles mover)
#export LD_PRELOAD=libetc.so

#Default Browser is Opera, unless in TTY then it's links
# Browser
if [ -n "$DISPLAY" ]; then
        BROWSER=opera
else
        BROWSER=links
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f /home/.bash_aliases ]; then
    . /home/.bash_aliases
fi
