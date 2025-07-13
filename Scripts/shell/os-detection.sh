#!/usr/bin/env bash
#
# SuperClaude Framework v3.0 - OS Detection Module
#
# Provides operating system detection and platform-specific utilities
# for the SuperClaude installation system.
#

# Prevent multiple sourcing
if [[ "${SUPERCLAUDE_OS_DETECTION_LOADED:-}" == "true" ]]; then
    return 0
fi
readonly SUPERCLAUDE_OS_DETECTION_LOADED="true"


# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/debian_version ]; then
            echo "debian"
        elif [ -f /etc/redhat-release ]; then
            echo "redhat"
        elif [ -f /etc/arch-release ]; then
            echo "arch"
        else
            echo "linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        echo "windows"
    elif [[ "$OSTYPE" == "linux-gnu"* ]] && grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
    else
        echo "unknown"
    fi
}

# Get OS-specific package manager
get_package_manager() {
    local os_type="$1"
    
    case "$os_type" in
        "debian"|"wsl")
            echo "apt"
            ;;
        "redhat")
            if command -v dnf >/dev/null 2>&1; then
                echo "dnf"
            else
                echo "yum"
            fi
            ;;
        "arch")
            echo "pacman"
            ;;
        "macos")
            if command -v brew >/dev/null 2>&1; then
                echo "brew"
            else
                echo "manual"
            fi
            ;;
        "windows")
            if command -v winget >/dev/null 2>&1; then
                echo "winget"
            else
                echo "manual"
            fi
            ;;
        *)
            echo "manual"
            ;;
    esac
}

# Check if OS is supported
is_supported_os() {
    local os_type="$1"
    
    case "$os_type" in
        "debian"|"redhat"|"arch"|"macos"|"wsl")
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Get OS display name
get_os_display_name() {
    local os_type="$1"
    
    case "$os_type" in
        "debian")
            echo "Ubuntu/Debian"
            ;;
        "redhat")
            echo "RHEL/CentOS/Fedora"
            ;;
        "arch")
            echo "Arch Linux"
            ;;
        "macos")
            echo "macOS"
            ;;
        "windows")
            echo "Windows"
            ;;
        "wsl")
            echo "Windows Subsystem for Linux"
            ;;
        "linux")
            echo "Generic Linux"
            ;;
        *)
            echo "Unknown OS"
            ;;
    esac
}

# Check if running in container
is_container() {
    if [ -f /.dockerenv ]; then
        return 0
    fi
    
    if [ -f /proc/1/cgroup ]; then
        if grep -q docker /proc/1/cgroup 2>/dev/null; then
            return 0
        fi
        if grep -q lxc /proc/1/cgroup 2>/dev/null; then
            return 0
        fi
    fi
    
    return 1
}

# Check if running with sufficient privileges
check_privileges() {
    local os_type="$1"
    
    case "$os_type" in
        "debian"|"redhat"|"arch"|"linux"|"wsl")
            if [ "$EUID" -eq 0 ]; then
                log_warning "Running as root - this may cause permission issues"
                return 1
            fi
            
            # Check sudo access for package installation
            if ! sudo -n true 2>/dev/null; then
                log_warning "sudo access may be required for package installation"
            fi
            ;;
        "macos")
            # macOS typically doesn't need special privileges for user installations
            ;;
        "windows")
            # Windows privilege checking would be more complex
            ;;
    esac
    
    return 0
}

# Get shell configuration file
get_shell_config() {
    if [ -n "$ZSH_VERSION" ]; then
        echo "$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        if [ -f "$HOME/.bashrc" ]; then
            echo "$HOME/.bashrc"
        else
            echo "$HOME/.bash_profile"
        fi
    elif [ -f "$HOME/.profile" ]; then
        echo "$HOME/.profile"
    else
        echo "$HOME/.bashrc"  # Default fallback
    fi
}

# Get temporary directory
get_temp_dir() {
    if [ -n "$TMPDIR" ]; then
        echo "$TMPDIR"
    elif [ -d /tmp ]; then
        echo "/tmp"
    else
        echo "$HOME"
    fi
}
