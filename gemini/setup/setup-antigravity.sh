#!/data/data/com.termux/files/usr/bin/bash
# Antigravity CLI installation script for Termux
# This script installs and configures Antigravity CLI to work in Termux

set -e

echo "=== Antigravity CLI Installation for Termux ==="
echo ""

# Step 1: Update Termux packages and install dependencies
echo "[1/6] Installing dependencies..."
pkg update -y
pkg install -y proot-distro ca-certificates curl

# Step 2: Install Debian (required for glibc compatibility)
echo ""
echo "[2/6] Installing Debian (this may take a few minutes)..."
if ! proot-distro list 2>/dev/null | grep -q "debian"; then
    proot-distro install debian
    echo "Debian installed successfully"
else
    echo "Debian is already installed, skipping..."
fi

# Step 3: Install CA certificates in Debian
echo ""
echo "[3/6] Installing CA certificates in Debian..."
proot-distro login debian -- apt update -qq
proot-distro login debian -- apt install -y ca-certificates

# Step 4: Download antigravity CLI binary
echo ""
echo "[4/6] Downloading Antigravity CLI..."
mkdir -p ~/.local/bin
curl -fsSL https://antigravity.google/cli/install.sh | bash

# Step 5: Create wrapper script for agy
echo ""
echo "[5/6] Creating wrapper script..."
cat > ~/.local/bin/agy << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
# Get current working directory - will be mapped to Debian
CURRENT_DIR="$(pwd)"
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
export SSL_CERT_DIR=/etc/ssl/certs
proot-distro login debian --shared-tmp -- sh -c "cd '$CURRENT_DIR' 2>/dev/null || cd /root; /usr/local/bin/agy \"\$@\"" -- "$@"
EOF
chmod +x ~/.local/bin/agy

# Copy original binary to Debian
if [ -f ~/.local/bin/agy.orig ]; then
    echo "Copying binary to Debian..."
    proot-distro login debian -- sh -c "cat > /usr/local/bin/agy" < ~/.local/bin/agy.orig
    proot-distro login debian -- chmod +x /usr/local/bin/agy
else
    echo "Warning: Original binary not found at ~/.local/bin/agy.orig"
    echo "Please run the installation script from antigravity.google manually first"
    exit 1
fi

# Step 6: Create launcher script in ~/gemini
echo ""
echo "[6/6] Creating launcher script..."
mkdir -p ~/gemini
cat > ~/gemini/antigravity.sh << 'EOF'
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
EOF
chmod +x ~/gemini/antigravity.sh

# Final setup
echo ""
echo "=== Installation Complete! ==="
echo ""
echo "Antigravity CLI has been installed successfully."
echo ""
echo "Usage:"
echo "  1. Run from anywhere:        ~/.local/bin/agy"
echo "  2. Run from ~/gemini:        ~/gemini/antigravity.sh"
echo "  3. Run from custom dir:      ~/gemini/antigravity.sh /path/to/dir"
echo ""
echo "To use 'agy' command directly, add to PATH:"
echo "  echo 'export PATH=\$HOME/.local/bin:\$PATH' >> ~/.bashrc"
echo "  source ~/.bashrc"
echo ""
echo "Testing installation..."
~/.local/bin/agy --version && echo "✓ Antigravity CLI is working!"
