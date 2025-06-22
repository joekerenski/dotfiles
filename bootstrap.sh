#!/bin/bash
set -e

echo "Starting fresh system setup..."

if ! command -v chezmoi &> /dev/null; then
    sh -c "$(curl -fsLS get.chezmoi.io)"
fi

chezmoi init --apply joekerenski/dotfiles

echo "[OK]      Setup complete! Your system is ready."
echo "[INFO]    Don't forget to clone your gopass repository with a github PAT."

