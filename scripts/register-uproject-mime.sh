#!/usr/bin/env bash

set -euo pipefail

DESKTOP_ID="gondev-unreal-project.desktop"
MIME_TYPE="application/x-unreal-project"
APPLICATIONS_DIR="$HOME/.local/share/applications"
MIME_DIR="$HOME/.local/share/mime"
MIME_PACKAGES_DIR="$MIME_DIR/packages"
DESKTOP_FILE="$APPLICATIONS_DIR/$DESKTOP_ID"
MIME_FILE="$MIME_PACKAGES_DIR/gondev-unreal-project.xml"

require_command() {
    local command_name="$1"

    if ! command -v "$command_name" >/dev/null 2>&1; then
        printf 'register-uproject-mime: required command not found: %s\n' "$command_name" >&2
        exit 1
    fi
}

require_command ue-launch
require_command update-mime-database
require_command update-desktop-database
require_command xdg-mime

mkdir -p "$APPLICATIONS_DIR" "$MIME_PACKAGES_DIR"

cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Type=Application
Version=1.0
Name=Unreal Project
Comment=Open Unreal Engine project files with ue-launch
Exec=ue-launch %f
MimeType=$MIME_TYPE;
NoDisplay=true
Terminal=false
Categories=Development;
EOF

cat <<EOF > "$MIME_FILE"
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="$MIME_TYPE">
    <comment>Unreal Engine project</comment>
    <glob pattern="*.uproject"/>
  </mime-type>
</mime-info>
EOF

update-mime-database "$MIME_DIR"
update-desktop-database "$APPLICATIONS_DIR"
xdg-mime default "$DESKTOP_ID" "$MIME_TYPE"

printf 'register-uproject-mime: registered %s with %s\n' "$MIME_TYPE" "$DESKTOP_ID"
printf 'register-uproject-mime: desktop file written to %s\n' "$DESKTOP_FILE"
printf 'register-uproject-mime: mime file written to %s\n' "$MIME_FILE"
