#!/usr/bin/env bash
#
# SuperClaude Framework v3.0 - Requirements Checking Module
# This script should be sourced, not executed directly.
#

# Prevent multiple sourcing
if [[ "${SUPERCLAUDE_REQUIREMENTS_LOADED:-}" == "true" ]]; then
    return 0
fi
readonly SUPERCLAUDE_REQUIREMENTS_LOADED="true"

# Enable strict mode
set -euo pipefail

# Source dependencies
REQ_SHELL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$REQ_SHELL_DIR/common.sh"
source "$REQ_SHELL_DIR/os-detection.sh"

# Configuration file path
readonly REQUIREMENTS_CONFIG="$REQ_SHELL_DIR/config/requirements.yml"

# Parse YAML configuration
parse_yaml_config() {
    local config_file="$1"
    
    # Default versions
    local python_min="3.12"
    local node_min="18.0"
    local npm_min="6.0"
    local git_min="2.0"
    
    if [[ -f "$config_file" ]]; then
        log_info "Loading requirements from YAML configuration"
        
        while IFS= read -r line; do
            if [[ "$line" =~ ^[[:space:]]*([^:]+):[[:space:]]*$ ]]; then
                current_section="${BASH_REMATCH[1]}"
            elif [[ "$line" =~ ^[[:space:]]*min_version:[[:space:]]*([^[:space:]]+) ]]; then
                case "$current_section" in
                    "python") python_min="${BASH_REMATCH[1]}" ;;
                    "node") node_min="${BASH_REMATCH[1]}" ;;
                    "npm") npm_min="${BASH_REMATCH[1]}" ;;
                    "git") git_min="${BASH_REMATCH[1]}" ;;
                esac
            fi
        done < "$config_file"
    else
        log_warning "YAML config not found, using default versions"
    fi
    
    export PYTHON_MIN_VERSION="$python_min"
    export NODE_MIN_VERSION="$node_min"
    export NPM_MIN_VERSION="$npm_min"
    export GIT_MIN_VERSION="$git_min"
}

# Version comparison
version_compare() {
    local actual_version="$1"
    local min_version="$2"
    
    local actual_short=$(echo "$actual_version" | grep -oE '[0-9]+\.[0-9]+' | head -1)
    local min_short=$(echo "$min_version" | grep -oE '[0-9]+\.[0-9]+' | head -1)
    
    if [[ -z "$actual_short" || -z "$min_short" ]]; then
        return 1
    fi
    
    IFS='.' read -ra actual_parts <<< "$actual_short"
    IFS='.' read -ra min_parts <<< "$min_short"
    
    if (( actual_parts[0] > min_parts[0] )); then
        return 0
    elif (( actual_parts[0] < min_parts[0] )); then
        return 1
    fi
    
    if (( actual_parts[1] >= min_parts[1] )); then
        return 0
    else
        return 1
    fi
}

# Check requirement
check_requirement() {
    local req_name="$1"
    local command_name="$2"
    local min_version="$3"
    local version_pattern="$4"
    local required="$5"
    
    log_info "Checking $req_name..."
    
    if ! command_exists "$command_name"; then
        [[ "$required" == "true" ]] && log_error "$req_name not found" || log_warning "$req_name not found (optional)"
        return $(( required == "true" ? 1 : 0 ))
    fi
    
    local version_output="unknown"
    case "$command_name" in
        "python3")
            version_output=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))' 2>/dev/null || python3 --version 2>&1)
            ;;
        "node")
            version_output=$(node --version 2>/dev/null || echo "unknown")
            version_output=${version_output/v/}
            ;;
        *)
            version_output=$($command_name --version 2>/dev/null || echo "unknown")
            ;;
    esac
    
    if [[ "$version_output" == "unknown" ]]; then
        [[ "$required" == "true" ]] && log_warning "$req_name found but version unknown" || log_warning "$req_name found (version check skipped)"
        return $(( required == "true" ? 1 : 0 ))
    fi
    
    local actual_version
    if [[ -n "$version_pattern" ]]; then
        actual_version=$(echo "$version_output" | grep -oE "$version_pattern" | head -1)
    else
        actual_version=$(echo "$version_output" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
    fi
    
    if [[ -z "$actual_version" ]]; then
        [[ "$required" == "true" ]] && log_warning "$req_name found but version unparsable" || log_success "$req_name found"
        return $(( required == "true" ? 1 : 0 ))
    fi
    
    if version_compare "$actual_version" "$min_version"; then
        log_success "$req_name $actual_version (>= $min_version)"
        return 0
    else
        [[ "$required" == "true" ]] && log_error "$req_name $actual_version (needs >= $min_version)" || log_warning "$req_name $actual_version (recommended >= $min_version)"
        return $(( required == "true" ? 1 : 0 ))
    fi
}

# Main function
check_system_requirements() {
    log_header "System Requirements Check"
    
    parse_yaml_config "$REQUIREMENTS_CONFIG"
    local os_type=$(detect_os)
    log_info "OS: $(get_os_display_name "$os_type")"
    
    local requirements_met=true
    local missing_requirements=()
    
    declare -A requirements=(
        ["Python 3.12+"]="python3 $PYTHON_MIN_VERSION '[0-9]+\.[0-9]+(\.[0-9]+)?' true"
        ["Node.js 18+"]="node $NODE_MIN_VERSION '[0-9]+\.[0-9]+(\.[0-9]+)?' true"
        ["npm"]="npm $NPM_MIN_VERSION '[0-9]+\.[0-9]+(\.[0-9]+)?' true"
        ["Git"]="git $GIT_MIN_VERSION '[0-9]+\.[0-9]+(\.[0-9]+)?' true"
    )
    
    for req_name in "${!requirements[@]}"; do
        read -r cmd min_ver pattern required <<< "${requirements[$req_name]}"
        if ! check_requirement "$req_name" "$cmd" "$min_ver" "$pattern" "$required"; then
            requirements_met=false
            missing_requirements+=("$req_name")
        fi
    done
    
    check_requirement "Claude CLI" "claude" "0.1" '[0-9]+\.[0-9]+' "false"
    
    if [[ "$requirements_met" == true ]]; then
        log_success "All requirements met"
        return 0
    else
        log_error "Missing requirements:"
        for req in "${missing_requirements[@]}"; do
            show_installation_instructions "$req" "$os_type"
        done
        return 1
    fi
}

# Only run if executed directly
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    check_system_requirements
fi
