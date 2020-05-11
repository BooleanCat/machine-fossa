#!/usr/bin/env bash
set -euo pipefail

# Install homebrew
if ! brew -v &>/dev/null; then
	sudo apt --yes install build-essential curl file git
	CI=true /bin/bash -c "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh )"
	export PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
fi

if ! brew list | grep -q ansible; then
	brew install gcc ansible
fi

ansible-playbook \
	-i "localhost," \
	--ask-become-pass \
	--con local \
	playbook.yml
