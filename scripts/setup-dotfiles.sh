#!/bin/bash

echo "=========================================="
echo "  Dotfiles Installation from GitHub"
echo "=========================================="
echo ""
echo "This script will:"
echo "1. Install dotfiles from https://github.com/owieczka/dotfiles-linux-public"
echo "2. Create bare repo in ~/gitdotfiles"
echo "3. Optionally install additional software"
echo ""
read -p "Do you want to continue? (y/n): " confirm_install

if [[ ! "$confirm_install" =~ ^[Yy]$ ]]; then
    echo "Installation cancelled by user."
    exit 0
fi

echo ""
echo "Starting dotfiles installation..."

# Create gitdotfiles folder in home directory
mkdir -p "$HOME/gitdotfiles"

# Initialize bare repo
git init --bare "$HOME/gitdotfiles"

# Add remote
git --git-dir="$HOME/gitdotfiles" --work-tree="$HOME" remote add origin https://github.com/owieczka/dotfiles-linux-public

# Fetch data from master branch
git --git-dir="$HOME/gitdotfiles" --work-tree="$HOME" fetch origin master

# Checkout master branch
git --git-dir="$HOME/gitdotfiles" --work-tree="$HOME" checkout -f master

# Set branch tracking
git --git-dir="$HOME/gitdotfiles" --work-tree="$HOME" branch --set-upstream-to=origin/master master

# Hide untracked files in status
git --git-dir="$HOME/gitdotfiles" --work-tree="$HOME" config --local status.showUntrackedFiles no

#============================================================

# Ask for Git username and email
read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email

# Set user.name and user.email
git --git-dir="$HOME/gitdotfiles" --work-tree="$HOME" config --local user.name "$git_username"
git --git-dir="$HOME/gitdotfiles" --work-tree="$HOME" config --local user.email "$git_email"

#============================================================

# Add alias to .bashrc if it doesn't exist
if ! grep -q "alias gitdotfiles=" "$HOME/.bashrc" 2>/dev/null; then
    echo "alias gitdotfiles='git --git-dir=\$HOME/gitdotfiles --work-tree=\$HOME'" >> "$HOME/.bashrc"
    echo "Alias 'gitdotfiles' added to ~/.bashrc"
fi

#============================================================

# Ask about software installation
echo ""
echo "Available software for installation:"
echo "- Python 3.12, micro, fzf, bat, tmux, eza, fish"
echo "- zoxide, frogmouth, diff3, lazydocker, ripgrep, entr"
echo ""
read -p "Do you want to install additional software? (y/n): " install_software

if [[ ! "$install_software" =~ ^[Yy]$ ]]; then
    echo "Skipping software installation."
    echo ""
    echo "Dotfiles have been installed!"
    echo "Use: source ~/.bashrc to load 'gitdotfiles' alias"
    echo "Or use directly: git --git-dir=\$HOME/gitdotfiles --work-tree=\$HOME <command>"
    exit 0
fi

# Software installation
echo "=== Software Installation ==="

mkdir -p "$HOME/software-tmp"

if command -v sudo &> /dev/null; then
  SUDO="sudo"
else
  SUDO=""
fi

# Install Python 3.12
echo "Installing Python 3.12..."
if command -v python3.12 &> /dev/null; then
    echo "Python 3.12 already installed: $(python3.12 --version)"
else
    if command -v apt-get &> /dev/null; then
        echo "Adding deadsnakes PPA repository for Python 3.12..."
        $SUDO apt-get update
        $SUDO apt-get install -y software-properties-common
        $SUDO add-apt-repository -y ppa:deadsnakes/ppa
        $SUDO apt-get update
        $SUDO apt-get install -y python3.12 python3.12-venv python3.12-dev
        echo "Python 3.12 installed via apt-get"
        # Install pip for Python 3.12
        curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12
    elif command -v dnf &> /dev/null; then
        $SUDO dnf install -y python3.12 python3.12-pip
        echo "Python 3.12 installed via dnf"
    elif command -v yum &> /dev/null; then
        $SUDO yum install -y python3.12 python3.12-pip
        echo "Python 3.12 installed via yum"
    else
        echo "WARNING: Cannot install Python 3.12 automatically. Please install manually."
    fi
fi

# Install micro editor
echo "Installing micro editor..."
if command -v micro &> /dev/null; then
    echo "Micro already installed: $(micro -version)"
    MICRO_PATH="micro"
else
    echo "Trying to install micro via apt-get..."
    if command -v apt-get &> /dev/null && $SUDO apt-get update && $SUDO apt-get install -y micro; then
        echo "Micro zainstalowany via apt-get"
        MICRO_PATH="micro"
    else
        echo "Instalacja via apt-get nie powiodła się, używam alternatywnej metody..."
        cd "$HOME/software-tmp"
        curl https://getmic.ro | bash
        if command -v sudo &> /dev/null; then
            sudo mv micro /usr/local/bin/
            echo "Micro installed in /usr/local/bin/"
            MICRO_PATH="micro"
        elif [ -w /usr/local/bin ]; then
            mv micro /usr/local/bin/
            echo "Micro installed in /usr/local/bin/"
            MICRO_PATH="micro"
        else
            mkdir -p "$HOME/.local/bin"
            mv micro "$HOME/.local/bin/"
            if ! grep -q '$HOME/.local/bin' "$HOME/.bashrc" 2>/dev/null; then
                echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
            fi
            echo "Micro installed in ~/.local/bin/"
            MICRO_PATH="$HOME/.local/bin/micro"
        fi
    fi
fi

# Instalacja pluginów micro
echo "Installing micro plugins..."
$MICRO_PATH -plugin install lsp fzfinder filemanager

# Instalacja fzf
echo "Instalacja fzf..."
if command -v fzf &> /dev/null; then
    echo "fzf already installed: $(fzf --version)"
else
    echo "Trying to install fzf via apt-get..."
    if command -v apt-get &> /dev/null && $SUDO apt-get install -y fzf; then
        echo "fzf zainstalowany via apt-get"
    else
        echo "Instalacja via apt-get nie powiodła się, używam alternatywnej metody..."
        if [ ! -d "$HOME/.fzf" ]; then
            git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
            "$HOME/.fzf/install" --all --no-bash --no-zsh --no-fish
            echo "fzf installed!"
            if ! grep -q '$HOME/.fzf/bin' "$HOME/.bashrc" 2>/dev/null; then
                echo 'export PATH="$HOME/.fzf/bin:$PATH"' >> "$HOME/.bashrc"
                echo "fzf added to PATH in ~/.bashrc"
            fi
        fi
    fi
fi

# Instalacja bat
echo "Instalacja bat..."
if command -v bat &> /dev/null; then
    echo "bat already installed: $(bat --version)"
else
    echo "Trying to install bat via apt-get..."
    if command -v apt-get &> /dev/null && sudo apt-get install -y bat; then
        echo "bat zainstalowany via apt-get"
        # W Ubuntu bat jest instalowany jako batcat
        if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
            mkdir -p "$HOME/.local/bin"
            # ln -s "$(which batcat)" "$HOME/.local/bin/bat"
            $SUDO ln -s "$(which batcat)" "/usr/local/bin/bat"
            echo "Created alias bat -> batcat"
        fi
    else
        echo "Instalacja via apt-get nie powiodła się, używam alternatywnej metody..."
        cd "$HOME/software-tmp"
        BAT_VERSION="0.24.0"
        wget "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz"
        tar -xzf "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz"
        if command -v sudo &> /dev/null; then
            sudo mv "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl/bat" /usr/local/bin/
            echo "bat zainstalowany w /usr/local/bin/"
        elif [ -w /usr/local/bin ]; then
            mv "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl/bat" /usr/local/bin/
            echo "bat zainstalowany w /usr/local/bin/"
        else
            mkdir -p "$HOME/.local/bin"
            mv "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl/bat" "$HOME/.local/bin/"
            echo "bat zainstalowany w ~/.local/bin/"
        fi
    fi
fi

# Instalacja tmux
echo "Instalacja tmux..."
if command -v tmux &> /dev/null; then
    echo "tmux already installed: $(tmux -V)"
else
    if command -v apt-get &> /dev/null; then
        $SUDO apt-get update && $SUDO apt-get install -y tmux
        echo "tmux zainstalowany via apt-get"
    elif command -v yum &> /dev/null; then
        $SUDO yum install -y tmux
        echo "tmux installed via yum"
    elif command -v dnf &> /dev/null; then
        $SUDO dnf install -y tmux
        echo "tmux installed via dnf"
    else
        echo "WARNING: Cannot install tmux automatically. Install ręcznie."
    fi
fi

# Instalacja tmux plugin manager (TPM)
echo "Instalacja Tmux Plugin Manager..."
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "TPM already installed"
else
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    echo "TPM installed! Użyj 'prefix + I' in tmux to install plugins"
fi

# Instalacja eza
echo "Instalacja eza..."
if command -v eza &> /dev/null; then
    echo "eza already installed: $(eza --version | head -n1)"
else
    if command -v apt-get &> /dev/null; then
        $SUDO apt-get install -y eza 2>/dev/null && echo "eza zainstalowany via apt-get" || {
            echo "Instalacja via apt-get nie powiodła się, używam alternatywnej metody..."
            cd "$HOME/software-tmp"
            EZA_VERSION="0.18.2"
            wget "https://github.com/eza-community/eza/releases/download/v${EZA_VERSION}/eza_x86_64-unknown-linux-musl.tar.gz"
            tar -xzf "eza_x86_64-unknown-linux-musl.tar.gz"
            $SUDO mv eza /usr/local/bin/
            echo "eza zainstalowany w /usr/local/bin/"
        }
    elif command -v yum &> /dev/null; then
        $SUDO yum install -y eza 2>/dev/null && echo "eza installed via yum" || echo "WARNING: Cannot install eza przez yum"
    elif command -v dnf &> /dev/null; then
        $SUDO dnf install -y eza 2>/dev/null && echo "eza installed via dnf" || echo "WARNING: Cannot install eza przez dnf"
    else
        echo "WARNING: Cannot install eza automatically. Install ręcznie."
    fi
fi

# Instalacja fish
echo "Instalacja fish..."
if command -v fish &> /dev/null; then
    echo "fish already installed: $(fish --version)"
else
    if command -v apt-get &> /dev/null; then
        $SUDO apt-get update && $SUDO apt-get install -y fish
        echo "fish zainstalowany via apt-get"
    elif command -v yum &> /dev/null; then
        $SUDO yum install -y fish
        echo "fish installed via yum"
    elif command -v dnf &> /dev/null; then
        $SUDO dnf install -y fish
        echo "fish installed via dnf"
    else
        echo "WARNING: Cannot install fish automatically. Install ręcznie."
    fi
fi

# Instalacja zoxide
echo "Instalacja zoxide..."
if command -v zoxide &> /dev/null; then
    echo "zoxide already installed: $(zoxide --version)"
else
    echo "Installing zoxide via curl..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    echo "zoxide installed!"
    # Dodanie zoxide do PATH jeśli zainstalowany w ~/.local/bin
    if [ -f "$HOME/.local/bin/zoxide" ]; then
        if ! grep -q '$HOME/.local/bin' "$HOME/.bashrc" 2>/dev/null; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        fi
    fi
fi

# Instalacja frogmouth
echo "Instalacja frogmouth..."
if command -v frogmouth &> /dev/null; then
    echo "frogmouth already installed"
elif command -v pip3 &> /dev/null || command -v pip &> /dev/null; then
    echo "Installing frogmouth via pip..."
    if command -v pip3 &> /dev/null; then
        pip3 install --user frogmouth
    else
        pip install --user frogmouth
    fi
    echo "frogmouth installed!"
    # Ensuring that ~/.local/bin is in PATH
    if ! grep -q '$HOME/.local/bin' "$HOME/.bashrc" 2>/dev/null; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi
else
    echo "UWAGA: pip/pip3 niedostępne. Install Python i pip aby zainstalować frogmouth."
fi

# Instalacja diff3
echo "Instalacja diff3..."
if command -v diff3 &> /dev/null; then
    echo "diff3 already installed: $(diff3 --version | head -n1)"
else
    if command -v apt-get &> /dev/null; then
        $SUDO apt-get install -y diffutils
        echo "diff3 zainstalowany via apt-get (part of diffutils)"
    elif command -v yum &> /dev/null; then
        $SUDO yum install -y diffutils
        echo "diff3 installed via yum (part of diffutils)"
    elif command -v dnf &> /dev/null; then
        $SUDO dnf install -y diffutils
        echo "diff3 installed via dnf (part of diffutils)"
    else
        echo "WARNING: Cannot install diff3 automatically. Install ręcznie."
    fi
fi

# Instalacja lazydocker
echo "Installing lazydocker..."
if command -v lazydocker &> /dev/null; then
    echo "lazydocker already installed: $(lazydocker --version)"
else
    echo "Installing lazydocker..."
    cd "$HOME/software-tmp"
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    
    # Sprawdzenie gdzie został zainstalowany
    if [ -f "$HOME/.local/bin/lazydocker" ]; then
        echo "lazydocker installed in ~/.local/bin/"
        if ! grep -q '$HOME/.local/bin' "$HOME/.bashrc" 2>/dev/null; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        fi
    elif [ -f "/usr/local/bin/lazydocker" ]; then
        echo "lazydocker installed in /usr/local/bin/"
    else
        echo "lazydocker installed!"
    fi
fi

# Instalacja ripgrep
echo "Instalacja ripgrep..."
if command -v rg &> /dev/null; then
    echo "ripgrep already installed: $(rg --version | head -n1)"
elif [ -n "$SUDO" ]; then
    if command -v apt-get &> /dev/null; then
        $SUDO apt-get install -y ripgrep
        echo "ripgrep zainstalowany via apt-get"
    elif command -v dnf &> /dev/null; then
        $SUDO dnf install -y ripgrep
        echo "ripgrep installed via dnf"
    elif command -v yum &> /dev/null; then
        $SUDO yum install -y ripgrep
        echo "ripgrep installed via yum"
    else
        echo "Installing via GitHub releases..."
        cd "$HOME/software-tmp"
        RG_VERSION="14.1.0"
        wget "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
        tar -xzf "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
        $SUDO mv "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg" /usr/local/bin/
        echo "ripgrep zainstalowany w /usr/local/bin/"
    fi
else
    echo "Installing via GitHub releases without sudo..."
    cd "$HOME/software-tmp"
    RG_VERSION="14.1.0"
    wget "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    mkdir -p "$HOME/.local/bin"
    mv "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg" "$HOME/.local/bin/"
    if ! grep -q '$HOME/.local/bin' "$HOME/.bashrc" 2>/dev/null; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi
    echo "ripgrep zainstalowany w ~/.local/bin/"
fi

# Instalacja entr
echo "Instalacja entr..."
if command -v entr &> /dev/null; then
    echo "entr already installed"
else
    if command -v apt-get &> /dev/null; then
        $SUDO apt-get install -y entr
        echo "entr zainstalowany via apt-get"
    elif command -v dnf &> /dev/null; then
        $SUDO dnf install -y entr
        echo "entr installed via dnf"
    elif command -v yum &> /dev/null; then
        $SUDO yum install -y entr
        echo "entr installed via yum"
    else
        echo "WARNING: Cannot install entr automatically. Install ręcznie."
    fi
fi

#============================================================

echo "Dotfiles have been installed!"
echo "Use: source ~/.bashrc to load alias 'gitdotfiles'"
echo "Or use directly: git --git-dir=\$HOME/gitdotfiles --work-tree=\$HOME <komenda>"
