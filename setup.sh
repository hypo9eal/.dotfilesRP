#
# Var
#

BUILD_ROOT=~/Build
DOTFILES_ROOT=~/.dotfiles

#
# update
#

sudo apt-get update
sudo apt-get upgrade
sudo rpi-update

#
# Directory
#

mkdir ${BUILD_ROOT}
mkdir ~/Development
cd

#
# avahi
#

sudo apt-get avahi-daemon

#
# oh-my-zsh
#

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
sh -s `which zsh`

#
# git
#
# https://www.kernel.org/pub/software/scm/git/

sudo aptitude install autoconf automake ncurses-dev gettext libghc-zlib-dev libcurl4-openssl-dev
cd ${BUILD_ROOT}
curl https://www.kernel.org/pub/software/scm/git/git-2.7.2.tar.gz git.tar.gz | tar xvf -
cd git.tar.gz
./configure --prefix=/usr/local --with-curl --with-expat
make
sudo make install
cd

#
# diff-hightlight
#

cd /usr/local/bin
sudo curl -L https://raw.github.com/git/git/master/contrib/diff-highlight/diff-highlight -o diff-highlight
sudo chmod +x diff-highlight
cd

#
# *env
#

### direnv
### https://github.com/direnv/direnv/releases

cd ${BUILD_ROOT}
curl -L https://github.com/direnv/direnv/releases/download/v2.6.0/direnv.linux-arm > direnv
sudo install direnv /usr/local/bin
ln -s ~/.dotfiles/.direnvrc ~/.direnvrc
cd

### anyenv

git clone https://github.com/riywo/anyenv ~/.anyenv
echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.your_profile
echo 'eval "$(anyenv init -)"' >> ~/.your_profile

### pyenv

anyenv install pyenv
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev

#
# virtualenv
#

sudo pip3 install virtualenv

#
# tightvncserver
#

sudo apt-get install tightvncserver

#
# Symlink
#

echo "\n>> symbolic link ~/.vimrc -> ${DOTFILES_ROOT}/.vimrc"
ln -s ${DOTFILES_ROOT}/.vimrc ~/.vimrc

echo "\n>> symbolic link ~/.zshrc -> ${DOTFILES_ROOT}/.zshrc"
ln -s ${DOTFILES_ROOT}/.zshrc ~/.zshrc

echo "\n>> symbolic link ~/.gitconfig -> ${DOTFILES_ROOT}/.gitconfig"
ln -s ${DOTFILES_ROOT}/.gitconfig ~/.gitconfig

exec $SHELL -l
