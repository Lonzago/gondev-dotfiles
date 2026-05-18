#!/usr/bin/env bash
#
# stow-deploy.sh - Backup existing configs and deploy dotfiles via stow
#
# Usage: ./stow-deploy.sh [--dry-run]
#

set -e

DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "🔍 Dry run mode enabled — no changes will be made"
fi

# Packages to stow and their target locations
# Format: "package_name:target_parent:target_name"
# For zsh target_parent is ~ (home), for others it's ~/.config
PACKAGES=(
    "hypr:.config:hypr"
    "nvim:.config:nvim"
    "kitty:.config:kitty"
    "waybar:.config:waybar"
    "walker:.config:walker"
    "yazi:.config:yazi"
    "fastfetch:.config:fastfetch"
    "zsh:~:.zshrc"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

echo "📁 Dotfiles repo: $REPO_ROOT"
echo ""

backup_existing() {
    local package="$1"
    local target_parent="$2"
    local target_name="$3"

    # Resolve the actual path
    local target_path
    if [[ "$target_parent" == "~" ]]; then
        target_path="$HOME/$target_name"
    else
        target_path="$HOME/$target_parent/$target_name"
    fi

    # Check if the target exists (file or directory or symlink)
    if [[ -e "$target_path" ]]; then
        local backup_path="${target_path}.bak"
        local counter=1

        # Find available backup name
        while [[ -e "$backup_path" ]]; do
            backup_path="${target_path}.bak$counter"
            ((counter++))
        done

        if [[ "$DRY_RUN" == "true" ]]; then
            echo "  [DRY-RUN] Would rename: $target_path -> $backup_path"
        else
            echo "  📦 Backing up: $target_path -> $backup_path"
            mv "$target_path" "$backup_path"
        fi
    else
        echo "  ✓ No existing $target_path — safe to stow"
    fi
}

run_stow() {
    cd "$REPO_ROOT"

    if [[ "$DRY_RUN" == "true" ]]; then
        echo ""
        echo "  [DRY-RUN] Would run: stow -t ~ ."
        echo ""
        echo "Packages that would be stowed:"
        for pkg in "${PACKAGES[@]}"; do
            echo "    - ${pkg%%:*}"
        done
    else
        echo ""
        echo "🚀 Running stow..."
        stow -t ~ .
        echo ""
        echo "✅ Deployment complete!"
    fi
}

# Main
echo "=== Dotfiles Deployment ==="
echo ""

# Backup existing configs
echo "Checking for existing configs to backup..."
for entry in "${PACKAGES[@]}"; do
    package="${entry%%:*}"
    rest="${entry#*:}"
    target_parent="${rest%%:*}"
    target_name="${rest#*:}"

    echo "  Checking $package -> $target_parent/$target_name"
    backup_existing "$package" "$target_parent" "$target_name"
done

# Run stow
run_stow