#!/bin/bash

system_type=$(uname -s)

is_command() {
	command -v "$1" > /dev/null 2>&1
}

# macOS
if [ "$system_type" = "Darwin" ]; then
	# install zsh·
	if ! is_command zsh; then
		echo "Installing zsh..."
		brew install zsh
		if [ $? -eq 0 ]; then
			echo "All packages are installed."
		else
			echo "Install zsh error."
		fi
	else
		echo "zsh is already existed."
	fi
fi