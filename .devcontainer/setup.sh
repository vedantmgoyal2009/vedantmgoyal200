#!/usr/bin/env bash

# postStartCommand: "bash /workspace/.devcontainer/setup.sh"
if [ -n "$1" ]; then
    echo "Mode: postAttachCmd/postStartCmd"
    gh codespace ports visibility 59457:public 59456:public 3000:private -c $CODESPACE_NAME
    screen -dmS bot1 npm run gh-bot
    brew update && brew upgrade oh-my-posh
    exit
fi

# Directories
script_folder="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
workspaces_folder="$(cd "${script_folder}/../.." && pwd)"

# Installing softwares
sudo apt-get update
sudo apt install -y npm neofetch default-jre default-jdk screen build-essential procps curl file git
# Install brew and add to path, reload shell
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
source ~/.profile
# Install oh-my-posh
brew install jandedobbeleer/oh-my-posh/oh-my-posh
# Copy PowerShell Profile
mkdir -p $(pwsh -Command '$PROFILE | Split-Path')
cp "${workspaces_folder}/vedantmgoyal2009/.devcontainer/profile.ps1" $(pwsh -Command '$PROFILE')
# Add oh-my-posh to bash profile
echo 'eval "$(oh-my-posh init bash -c $(brew --prefix oh-my-posh)/themes/takuya.omp.json)"' >> /home/vscode/.bashrc
# Install winget-pkgs yamlcreate powershell-yaml
# pwsh -Command "Install-Module -Name powershell-yaml -Force"

# Multi-repo setup
clone-repo()
{
    cd "${workspaces_folder}"
    if [ ! -d "$1" ]; then
        git clone "https://github.com/$1"
    else 
        echo "Already cloned $1"
    fi
}

clone-repo "vedantmgoyal2009/winget-manifests-manager"
clone-repo "vedantmgoyal2009/winget-releaser"
clone-repo "vedantmgoyal2009/Komac"

# Install npm node_modules
cd "${workspaces_folder}/winget-manifests-manager"
sudo npm install
cd "${workspaces_folder}/winget-releaser"
sudo npm install

# Multi-root workspace
cd "${workspaces_folder}/winget-manifests-manager"
code-insiders multi-root.code-workspace
