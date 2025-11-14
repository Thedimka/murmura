#!/bin/bash

set -euo pipefail

readonly SCRIPT_URL="https://raw.githubusercontent.com/USER/murmura/main/murmura"
readonly INSTALL_DIR="/usr/local/bin"
readonly SCRIPT_NAME="murmura"
readonly TEMP_DIR=$(mktemp -d)

cleanup() {
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

check_requirements() {
    if ! command -v curl &>/dev/null && ! command -v wget &>/dev/null; then
        echo "Error: Either curl or wget is required for installation" >&2
        exit 1
    fi
    
    if [[ $EUID -ne 0 ]]; then
        echo "Error: This script must be run as root (use sudo)" >&2
        exit 1
    fi
}

download_script() {
    local temp_script="$TEMP_DIR/$SCRIPT_NAME"
    
    echo "Downloading murmura script..."
    
    if command -v curl &>/dev/null; then
        if ! curl -sSL "$SCRIPT_URL" -o "$temp_script"; then
            echo "Error: Failed to download script with curl" >&2
            exit 1
        fi
    elif command -v wget &>/dev/null; then
        if ! wget -q "$SCRIPT_URL" -O "$temp_script"; then
            echo "Error: Failed to download script with wget" >&2
            exit 1
        fi
    fi
    
    if [[ ! -f "$temp_script" ]] || [[ ! -s "$temp_script" ]]; then
        echo "Error: Downloaded script is empty or missing" >&2
        exit 1
    fi
    
    if ! head -1 "$temp_script" | grep -q "^#!/bin/bash"; then
        echo "Error: Downloaded file does not appear to be a bash script" >&2
        exit 1
    fi
    
    echo "$temp_script"
}

install_script() {
    local temp_script="$1"
    local install_path="$INSTALL_DIR/$SCRIPT_NAME"
    
    echo "Installing murmura to $install_path..."
    
    if [[ ! -d "$INSTALL_DIR" ]]; then
        mkdir -p "$INSTALL_DIR"
    fi
    
    cp "$temp_script" "$install_path"
    chmod +x "$install_path"
    
    echo "$install_path"
}

verify_installation() {
    local install_path="$1"
    
    echo "Verifying installation..."
    
    if [[ ! -x "$install_path" ]]; then
        echo "Error: Script is not executable at $install_path" >&2
        exit 1
    fi
    
    if ! "$install_path" --help &>/dev/null && ! "$install_path" &>/dev/null; then
        echo "Warning: Script may not be working correctly, but installation completed"
        return 0
    fi
    
    echo "Installation verified successfully!"
}

main() {
    echo "Murmura System Info Tool - Installation Script"
    echo "=============================================="
    echo
    
    check_requirements
    
    local temp_script
    temp_script=$(download_script)
    
    local install_path
    install_path=$(install_script "$temp_script")
    
    verify_installation "$install_path"
    
    echo
    echo "Installation completed successfully!"
    echo "You can now run: murmura"
    echo
    echo "If the command is not found, you may need to:"
    echo "1. Restart your terminal, or"
    echo "2. Run: source ~/.bashrc (or ~/.zshrc)"
    echo "3. Or add $INSTALL_DIR to your PATH"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi