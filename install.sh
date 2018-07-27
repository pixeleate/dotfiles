command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."
cp ./nvim/init.vim ~/.config/nvim/ 
cp ./nvim/.init.vim ~/.config/nvim/

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s "$(which zsh)"
fi

echo "Restarting terminal"
source ~/.zshrc

rm ~/.zshrc

echo "source ~/dotfiles/zsh/.zshrc" >> ~/.zshrc

echo "cloning fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

echo "Installing fZF"
~/.fzf/install


echo "Brew installing"

echo "Brewing ripgrep"
brew install ripgrep

echo "Brewing fd"
brew install fd

echo "Initializing submodule(s)"
git submodule update --init --recursive

source ./git/git.sh

# only perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    echo -e "\\n\\nRunning on OSX"
    echo -e "\\n\\nInstalling Brew...."
    source install/brew.sh

fi

echo "creating vim directories"
mkdir -p ~/.vim-tmp


echo "Done. Reload your terminal."
