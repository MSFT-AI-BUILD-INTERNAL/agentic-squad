#!/usr/bin/env bash
set -euo pipefail

version_lt() {
    [ "$1" != "$2" ] && [ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | head -n1)" = "$1" ]
}

detect_copilot_package() {
    local copilot_package="@github/copilot"

    if [[ "$(uname -s)" == "Linux" ]] && command -v getconf &>/dev/null; then
        local glibc_version
        glibc_version="$(getconf GNU_LIBC_VERSION 2>/dev/null | awk '{print $2}')"

        if [[ -n "$glibc_version" ]] && version_lt "$glibc_version" "2.33"; then
            copilot_package="@github/copilot@1.0.45"
            echo "  -> Detected glibc $glibc_version; installing Copilot CLI 1.0.45 for Ubuntu 20.04 compatibility." >&2
        fi
    fi

    printf '%s\n' "$copilot_package"
}

echo "========================================="
echo " Codespace Environment Setup"
echo "========================================="

# -------------------------------------------
# 1. GitHub Copilot CLI (standalone binary via npm)
# -------------------------------------------
echo ""
echo "[1/4] Installing GitHub Copilot CLI..."
COPILOT_PACKAGE="$(detect_copilot_package)"
npm install -g "$COPILOT_PACKAGE"
echo "  -> Done."

# -------------------------------------------
# 2. Azure CLI
# -------------------------------------------
echo ""
echo "[2/4] Installing Azure CLI..."
if command -v az &>/dev/null; then
    echo "  -> Azure CLI already installed ($(az version --output tsv --query '\"azure-cli\"' 2>/dev/null || echo 'unknown'))."
else
    # Remove stale Yarn repo that causes GPG key errors in Codespaces
    sudo rm -f /etc/apt/sources.list.d/yarn.list
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi
echo "  -> Done."

# -------------------------------------------
# 3. Squad CLI (https://github.com/bradygaster/squad)
# -------------------------------------------
echo ""
echo "[3/4] Installing Squad CLI..."
if ! command -v node &>/dev/null; then
    echo "  -> Node.js not found. Installing via nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    # shellcheck source=/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm install --lts
fi
npm install -g @bradygaster/squad-cli
# npm can skip the native node-pty dependency during global install.
SQUAD_CLI_DIR="$(npm root -g)/@bradygaster/squad-cli"
(cd "$SQUAD_CLI_DIR" && npm install)
squad init
echo "  -> Done."

# -------------------------------------------
# 4. uv (Python Package Manager)
# -------------------------------------------
echo ""
echo "[4/4] Installing uv..."
if command -v uv &>/dev/null; then
    echo "  -> uv already installed ($(uv --version 2>/dev/null || echo 'unknown')). Upgrading..."
    uv self update || true
else
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi
# Ensure uv is on PATH for the current session
export PATH="$HOME/.local/bin:$PATH"
echo "  -> Done."

# -------------------------------------------
# Summary
# -------------------------------------------
echo ""
echo "========================================="
echo " Setup Complete!"
echo "========================================="
echo ""
echo "Installed versions:"
echo "  copilot    : $(copilot --version 2>/dev/null || echo 'run: copilot --version')"
echo "  az         : $(az version --output tsv --query '"azure-cli"' 2>/dev/null || echo 'run: az --version')"
echo "  squad      : $(squad --version 2>/dev/null || echo 'run: squad --version')"
echo "  uv         : $(uv --version 2>/dev/null || echo 'run: uv --version')"
echo ""
