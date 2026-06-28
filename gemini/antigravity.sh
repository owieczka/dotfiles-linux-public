#!/data/data/com.termux/files/usr/bin/bash
# Antigravity CLI launcher script

# Set working directory: use first argument as directory, or default to ~/gemini
WORK_DIR="${1:-$HOME/gemini}"

# If first argument is a directory, shift it out and change to it
if [ -d "$1" ]; then
    cd "$WORK_DIR"
    shift
fi

~/.local/bin/agy "$@"
