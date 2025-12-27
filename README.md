```
  _                    _             _  
 | |    __ _ _ __ ___ | |__       _-(")-
 | |   / _` | '_ ` _ \| '_ \    `%%%%%  
 | |__| (_| | | | |_| | |_) | _  // \\  
 |_____\__,_|_| |_| |_|_.__/_| |__  ___ 
                  | |   / _` | '_ \/ __|
                  | |__| (_| | |_) \__ \
  2025-03-08      |_____\__,_|_.__/|___/
```

# Tools

- fzf
- bat
- micro editor
  - filemanager
  - fzfinder
- tmux 3.3a
  - ressurect
  - continuum
- eza
- zoxide
- fish
- frogmouth
- glow
- diff3
- lazydocker
- ripgrep
- entr
- git log style

# ToDo

- Installation script
- Dodanie konfiguracji Basha
- Add fish configuration to repo
- tmuxinator if directory exists
- Move `.tmux.conf` do `~/.config/tmux/`
- Micro Theme
- fzf-start.sh - to into a tmux popup window and command
- Man in tmux
- diff3
- git log
- fd

# Fzf

Fzf (fuzzy finder) is a general-purpose command-line fuzzy finder. It's an interactive Unix filter for command-line that can be used with any list: files, command history, processes, hostnames, bookmarks, git commits, etc.

## Installation

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

Add to PATH:
```bash
export PATH="$HOME/.fzf/bin:$PATH"
```

# Bat

Bat is a cat clone with syntax highlighting and Git integration. It supports automatic paging, line numbering, and file concatenation. It's used in Micro fzfinder plugin to easily preview files before opening.

## Installation

Download the latest release:
```bash
cd /tmp
BAT_VERSION="0.24.0"
wget "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz"
tar -xzf "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl.tar.gz"
sudo mv "bat-v${BAT_VERSION}-x86_64-unknown-linux-musl/bat" /usr/local/bin/
```

## Usage

```bash
bat file.txt           # Display file with syntax highlighting
bat file1.txt file2.txt  # Concatenate files
bat --style=plain file.txt  # Plain output without decorations
```

# Micro editor

Micro editor is my favorite text editor for terminal. 

## Installation

```bash
cd /tmp
curl https://getmic.ro | bash
sudo mv micro /usr/local/bin/
```

In my configuration I have use:

- 2 spaces indentation
- spaces instead of tabs
- word warp

Custom bindings

- `Alt-o` - open file via fzfinder

## Plugins

- filemanager
- fzfinder
- lsp (https://github.com/AndCake/micro-plugin-lsp)

`micro -plugin install lsp fzfinder filemanager`

### LSP

Language server protocoll support for Micro editor

`Alt-k` - Show function signature on status bar
`Alt-r` - Show references to the current symbol in buffer
`Alt-d` - open function definition in a new tab
`Alt-f` - Format document
`Ctrl-space` - auto completion

requires:
- python: python-lsp-server, pylsp-mypy
- javascript: deno `curl -fsSL https://deno.land/install.sh | sh`
- lua: 

# Tmux

Tmux (terminal multiplexer) is a terminal multiplexer that allows you to switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal. It's essential for remote work and managing multiple terminal sessions.

## Installation

Using package manager:
```bash
# Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y tmux

# Fedora
sudo dnf install -y tmux

# CentOS/RHEL
sudo yum install -y tmux
```

## Basic Usage

```bash
tmux                    # Start new session
tmux new -s mysession   # Start new session with name
tmux attach -t mysession # Attach to existing session
tmux ls                 # List sessions
```

### Key Bindings (prefix: Ctrl+b)

- `prefix + c` - Create new window
- `prefix + n` - Next window
- `prefix + p` - Previous window
- `prefix + %` - Split pane vertically
- `prefix + "` - Split pane horizontally
- `prefix + arrow` - Navigate between panes
- `prefix + d` - Detach from session

## Tmux Plugin maganer

`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

prefix + I - install plugin

## Resurest

prefix + Ctrl-S - zapis sesji
prefix + Ctrl-R - restore sesion form file

# Tmuxinator

`tx-start` - alias for great tool `tmuxinator-fzf-start.sh` which allows to start tmux session from project

`tx` - because `tmuxinator` is too long for me I use `tx` alias


# Eza

Eza is a modern replacement for the traditional `ls` command. It provides better defaults, colors, icons, and git integration out of the box. It's written in Rust and is much faster than ls with similar features to exa.

## Installation

Using package manager:
```bash
# Ubuntu/Debian (newer versions)
sudo apt-get install -y eza

# Fedora
sudo dnf install -y eza
```

Or download binary release:
```bash
cd /tmp
EZA_VERSION="0.18.2"
wget "https://github.com/eza-community/eza/releases/download/v${EZA_VERSION}/eza_x86_64-unknown-linux-musl.tar.gz"
tar -xzf "eza_x86_64-unknown-linux-musl.tar.gz"
sudo mv eza /usr/local/bin/
```

## Usage

```bash
eza              # List files
eza -l           # Long format
eza -la          # Long format with hidden files
eza -T           # Tree view
eza --git        # Show git status
```

# Zoxide

Zoxide is a smarter cd command that remembers which directories you use most frequently. It allows you to quickly jump to directories by typing part of their name, learning from your habits over time.

## Installation

Using the official installer:
```bash
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

Add to your shell configuration:
```bash
# For bash
echo 'eval "$(zoxide init bash)"' >> ~/.bashrc

# For fish
echo 'zoxide init fish | source' >> ~/.config/fish/config.fish
```

## Usage

```bash
z foo              # cd to highest ranked directory matching foo
z foo bar          # cd to highest ranked directory matching foo and bar
zi foo             # cd with interactive selection using fzf
z -                # cd to previous directory
```

After installation, start using `cd` normally. Zoxide will track your directories and `z` will become more useful over time.

# Fish Shell

Fish (Friendly Interactive Shell) is a smart and user-friendly command-line shell with features like syntax highlighting, autosuggestions, tab completions that work out of the box, and a clean scripting syntax.

## Installation

Using package manager:
```bash
# Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y fish

# Fedora
sudo dnf install -y fish

# CentOS/RHEL
sudo yum install -y fish
```

## Set as default shell

```bash
chsh -s $(which fish)
```

## Features

- **Syntax highlighting** - Invalid commands are colored red
- **Autosuggestions** - Fish suggests commands as you type based on history
- **Tab completions** - Smart completions for commands, files, and options
- **Web-based configuration** - Run `fish_config` to configure in browser
- **No configuration needed** - Works great out of the box

## Configuration

Fish configuration is stored in `~/.config/fish/config.fish`

To reload configuration:
```bash
source ~/.config/fish/config.fish
```

# Frogmouth

Frogmouth is a Markdown browser and reader for the terminal. It's written in Python using Textual and provides a rich, interactive way to view Markdown documents with features like navigation, table of contents, code syntax highlighting, and more.

## Installation

Using pip:
```bash
# Install for current user
pip3 install --user frogmouth

# Or install globally (requires sudo)
sudo pip3 install frogmouth
```

Make sure `~/.local/bin` is in your PATH:
```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Usage

```bash
frogmouth README.md           # View a markdown file
frogmouth docs/               # Browse markdown files in a directory
frogmouth                     # Start with file picker
```

## Features

- **Interactive navigation** - Use arrow keys and vim-style navigation
- **Table of contents** - Auto-generated from headers
- **Syntax highlighting** - Code blocks with language-specific highlighting
- **Local file links** - Click links to navigate between documents
- **Bookmarks** - Save favorite documents for quick access

# Lazydocker

Lazydocker is a simple terminal UI for both Docker and Docker Compose. It provides an intuitive interface for managing containers, images, volumes, and networks without typing long docker commands.

## Installation

Using the official install script:
```bash
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
```

Or manually download the binary:
```bash
cd /tmp
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
tar xf lazydocker.tar.gz
sudo mv lazydocker /usr/local/bin
```

## Usage

```bash
lazydocker              # Start lazydocker
```

## Key Features

- **Container management** - View logs, stats, inspect, restart, stop containers
- **Image management** - View images, remove unused images, prune
- **Volume management** - View and manage volumes
- **Network inspection** - View Docker networks
- **Docker Compose support** - Manage compose projects
- **Keyboard shortcuts** - Vim-style navigation
- **Real-time stats** - CPU, memory usage per container

## Navigation

- `x` - Open menu for selected item
- `d` - Delete/remove selected item
- `e` - Exec into container
- `l` - View logs
- `s` - View stats
- `q` - Quit

# RipGrep

RipGrep (rg) is a line-oriented search tool that recursively searches your current directory for a regex pattern. It's extremely fast, respects .gitignore rules, and automatically skips hidden files/directories and binary files.

## Installation

Using package manager:
```bash
# Ubuntu/Debian
sudo apt-get install -y ripgrep

# Fedora
sudo dnf install -y ripgrep

# CentOS/RHEL
sudo yum install -y ripgrep
```

Or download binary release:
```bash
cd /tmp
RG_VERSION="14.1.0"
wget "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
tar -xzf "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
sudo mv "ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl/rg" /usr/local/bin/
```

## Usage

```bash
rg pattern                    # Search for pattern in current directory
rg pattern path/              # Search in specific directory
rg -i pattern                 # Case-insensitive search
rg -l pattern                 # Show only filenames with matches
rg -C 3 pattern               # Show 3 lines of context
rg --type py pattern          # Search only Python files
rg -g '*.js' pattern          # Search only .js files
rg --hidden pattern           # Search hidden files too
```

## Why RipGrep?

- **Blazingly fast** - Written in Rust, often faster than grep, ag, ack
- **Smart defaults** - Automatically ignores .gitignore patterns
- **Easy to use** - Simple syntax, colored output
- **Cross-platform** - Works on Linux, macOS, Windows

# Entr

Entr is a tools that looks after a list of provided files and execudes given command every time file changes

`ls *.js | entr -c node app.js`

# Diff3

Diff3 is a three-way file comparison and merge tool that's part of the GNU diffutils package. It's commonly used by version control systems like Git to perform three-way merges when conflicts occur.

## Installation

Using package manager:
```bash
# Ubuntu/Debian
sudo apt-get install -y diffutils

# Fedora
sudo dnf install -y diffutils

# CentOS/RHEL
sudo yum install -y diffutils
```

Note: diff3 is usually pre-installed on most Linux systems as part of the base diffutils package.

## Usage

```bash
# Basic three-way merge
diff3 myfile oldfile yourfile

# Merge with automatic conflict resolution
diff3 -m myfile oldfile yourfile > merged.txt

# Show only conflicts
diff3 -e myfile oldfile yourfile
```

## Git Integration

Git uses diff3 as a merge tool. You can configure it in `~/.gitconfig`:
```
[merge]
    tool = diff3
    conflictstyle = diff3
```

This shows the common ancestor version in conflict markers, making it easier to resolve merge conflicts.


# GitHub passwordless access

## Obtain SSH key pair

If you don't have SSH key pair, you need to generate one

`ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`

You can store them any where but by default it is in `~/.ssh/`

## Add private key to SSH agent

Start the SSH agent by:
`eval $(ssh-agent -s)` in BASH
`eval 'ssh-agnet -s` in FISH

Add your private key storen in `id_rsa_github` file to SSH agent

`ssh-add ~/.ssh/id_rsa_github`

## Add public key to github account

Copy the public key to you clipboard:

`cat ~/.ssh/id_rsa_github`

Visit your GitHub account settings, go to "SSH and GPG keys," and click on "New SSH key." Paste the copied key into the "Key" field and add a descriptive title.

## Add identification for github host

In SSH configuration file add identyfiaction key for GitHub host

```
Host github.com
	IdentityFile ~/.ssh/id_rsa_github
```

## Test SSH Connection

Test your SSH connection to GitHub

`ssh -T git@github.com`

in case of any problems use verbose mode for more information

`ssh -vT git@github.com`

# Create repositiory for dotfiles in $HOME directory

Written based on [Git Bare Repository - A Better Way To Manage Dotfiles (youtube.com)](https://www.youtube.com/watch?v=tBoLDpTWVOM)

## Repositorium initialization

Create directory for bare repo and hop on

`mkdir dotfiles-linux-public-repo`

`cd dotfiles-linux-public-repo`

Init bare git repository

`git init --bare`

Add remote repository

`git remote add origin https://github.com/owieczka/dotfiles-linux-public.git`

## First pull

Form a `dotfiles-linux-public-repo` execute pull command

`git --git-dir . --work-tree=$HOME pull origin master`

You may encounter a problem with already existing files in you Home directory. You must remove them before pulling or

`git --git-dir . --work-tree=$HOME fetch origin master`
`git --git-dir . --work-tree=$HOME checkout master -f`



Reload config for fish shell

`source ~/.config/fish/config.fish`

## Helper alias

For easier manipulation of your repository you can create an alias to appriopriate git command with necessary parameters. You don't need to do it if you pull from my repository where it have been already done. 

In `config.fish` you need to add flowing line

`alias gitdotfiles="/usr/bin/git --git-dir=$HOME/dotfiles-linux-repo --work-tree=$HOME"`

from now on instead using git command please use gitdotfiles command.

## Additional configurations

(optional) Add ssh passwordless write to repo

`gitdotfiles remote set-url origin git@github.com:owieczka/dotfiles-linux-public.git`

Disable showing a local untracked files

`gitdotfiles config --local status.showUntrackedFiles no`

Configure how commits with by signed

`gitdotfiles config --local user.name "Owieczka"`

`gitdotfiles config --local user.email "owieczka.owieczka"``

# Change log




