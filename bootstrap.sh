#!/usr/bin/env bash
set -xe

chezmoi init --apply --verbose git@github.com:kerenski/dotfiles.git
