#!/usr/bin/env bash
#
# SuperClaude Framework v3.0 - Interactive Installation Entry Point
#
# This script provides a unified entry point for SuperClaude installation,
# using a modular system with shell-based orchestration and interactive menus.
#
# Usage: ./install.sh [options]
# Options:
#   --skip-checks    Skip requirement checks (not recommended)
#   --standard       Standard installation (copy files)
#   --development    Development installation (symlinks)
#   --update         Update existing installation
#   --uninstall      Remove SuperClaude installation
#   --help           Show this help message

set -euo pipefail

# Color constants
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

# Logger
log_info()    { echo -e "${GREEN}[INFO]${RESET} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${RESET} $1"; }
log_error()   { echo -e "${RED}[ERROR]${RESET} $1" >&2; }

# Script configuration with fallbacks
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="${PROJECT_DIR:-$SCRIPT_DIR}"
readonly CLAUDE_GLOBAL_DIR="${CLAUDE_GLOBAL_DIR:-$HOME/.claude}"
readonly SHELL_DIR="${SHELL_DIR:-$SCRIPT_DIR/Scripts/shell}"
readonly LOG_FILE="${LOG_FILE:-$SCRIPT_DIR/install.log}"

# Error handling for missing modules
handle_module_error() {
    log_error "Required SuperClaude modules not found."
    echo -e "Please ensure you have the complete SuperClaude framework:
" >&2
    echo "  • Scripts/shell/common.sh" >&2
    echo "  • Scripts/shell/os-detection.sh" >&2
    echo "  • Scripts/shell/requirements.sh" >&2
    echo "  • Scripts/shell/operations/" >&2
    exit 1
}

# Validate all required modules are present
validate_modules() {
    local required_modules=(
        "$SHELL_DIR/common.sh"
        "$SHELL_DIR/os-detection.sh"
        "$SHELL_DIR/requirements.sh"
        "$SHELL_DIR/utils/security.sh"
        "$SHELL_DIR/operations/install.sh"
        "$SHELL_DIR/operations/update.sh"
        "$SHELL_DIR/operations/uninstall.sh"
    )

    for module in "${required_modules[@]}"; do
        if [ ! -f "$module" ]; then
            log_error "Missing module: $module"
            handle_module_error
        fi
    done
}

# Source all validated modules
source_modules() {
    source "$SHELL_DIR/common.sh"
    source "$SHELL_DIR/os-detection.sh"
    source "$SHELL_DIR/requirements.sh"
    source "$SHELL_DIR/utils/security.sh"
    source "$SHELL_DIR/operations/install.sh"
    source "$SHELL_DIR/operations/update.sh"
    source "$SHELL_DIR/operations/uninstall.sh"
}

# Show help
show_help() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "  --skip-checks     Skip requirement checks"
    echo "  --standard        Standard installation (copy files)"
    echo "  --development     Development installation (symlinks)"
    echo "  --update          Update existing installation"
    echo "  --uninstall       Remove SuperClaude installation"
    echo "  --help            Show this help message"
}

# Main logic
main() {
    [[ ! -d "$SHELL_DIR" ]] && handle_module_error

    validate_modules
    source_modules

    local SKIP_CHECKS=false
    local MODE=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --skip-checks)
                SKIP_CHECKS=true
                ;;
            --standard|--development|--update|--uninstall)
                MODE="$1"
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
        shift
    done

    if [[ "$SKIP_CHECKS" != true ]]; then
        log_info "Running requirement checks..."
        check_requirements
    fi

    case "$MODE" in
        --standard)
            log_info "Starting standard installation..."
            perform_standard_install
            ;;
        --development)
            log_info "Starting development installation..."
            perform_development_install
            ;;
        --update)
            log_info "Updating installation..."
            perform_update
            ;;
        --uninstall)
            log_warn "Uninstalling SuperClaude..."
            perform_uninstall
            ;;
        *)
            log_error "No mode selected. Use --help to see available options."
            exit 1
            ;;
    esac

    log_info "Operation completed."
}

main "$@"
