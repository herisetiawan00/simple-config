#!/bin/bash

set -e

echo "🚀 Starting Mac workspace setup..."


echo "📦 Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
    echo "⚙️ Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Configure Homebrew in your PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew is already installed."
fi

echo "🔄 Updating Homebrew..."
brew update
brew upgrade

echo "🛠️ Installing terminal tools..."
PACKAGES=(
    bash
    git
    jq
    aria2
    fzf
    mise
    podman
    tmux
    oh-my-posh
)

for package in "${PACKAGES[@]}"; do
    brew install "$package"
done

echo "🖥️ Installing macOS applications..."
CASKS=(
    # arc
    postman
)

for cask in "${CASKS[@]}"; do
    brew install --cask "$cask"
done

echo "----------------------------------------"
echo "💻 Which IDE(s) would you like to install?"
echo "0) Neovim"
echo "1) Visual Studio Code"
echo "2) IntelliJ IDEA (Community)"
echo "3) PyCharm (Community)"
echo "4) WebStorm"
echo "5) Android Studio"
echo "6) Cursor"
echo "----------------------------------------"

set +e 
echo "Enter the numbers separated by spaces (e.g., '1 3 6'), or press Enter to skip:"
read -p "> " ide_input
set -e

SELECTED_IDES=()

for choice in $ide_input; do
    case $choice in
        0) SELECTED_IDES+=("neovim") ;;
        1) SELECTED_IDES+=("visual-studio-code") ;;
        2) SELECTED_IDES+=("intellij-idea-ce") ;;
        3) SELECTED_IDES+=("pycharm-ce") ;;
        4) SELECTED_IDES+=("webstorm") ;;
        5) SELECTED_IDES+=("android-studio") ;;
        6) SELECTED_IDES+=("cursor") ;;
        *) echo "⚠️ Unknown option: $choice (skipping)" ;;
    esac
done

if [ ${#SELECTED_IDES[@]} -gt 0 ]; then
    echo "⚙️ Installing selected IDEs: ${SELECTED_IDES[*]}..."
    for ide in "${SELECTED_IDES[@]}"; do
        brew install --cask "$ide"
    done
else
    echo "⏭️ No IDEs selected. Skipping."
fi

# --- 6. Cleanup ---
echo "🧹 Cleaning up Homebrew..."
brew cleanup

echo "⭐️ Cloning simple config..."
git clone "https://github.com/herisetiawan00/simple-config.git" "$HOME/.simple"

echo "⚙️ Pleparing configuration..."
cd $HOME
CONFIG=(
  kitty
  mise
  nvim
  posh
  tmux
)

for config in "${CONFIG[@]}"; do
  ln -sf "$HOME/.simple/$config" "$HOME/.config/$config";
done

cd "$HOME/.simple"

git submodule update --init --remote external/

echo "source $HOME/.bashrc" > $HOME/.bash_profile

echo "
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=nvim

export ANDROID_HOME=$HOME/.android
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

export PATH=$PATH:$HOME/.pub-cache/bin

export SIMPLE=$HOME/.simple

. $SIMPLE/init.sh

eval "$(mise activate bash)"
eval "$(oh-my-posh init bash --config $SIMPLE/posh/theme.omp.json)"
export PATH="$HOME/.local/bin:$PATH"
" > $HOME/.bashrc

echo "/opt/homebrew/bin/bash" | sudo tee -a /etc/shells

chsh -s "/opt/homebrew/bin/bash"

echo "🎉 Mac workspace setup complete! Please restart your computer."
