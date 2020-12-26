#!/usr/bin/env bash
set -eo pipefail
# ----------------------------------
# APP_Purpose="install default app for lctech"
# APP_Author=zeki
# APP_Date=2020/12/10
# ----------------------------------
# * Step #1-1: Define variables
# ----------------------------------
VERSION="1"
DRY_MODE="false"
FLAG=$1
# MY_DIR="$(dirname "$0")" # DIR
GREEN='\033[0;32m'  # Green
YELLOW='\033[0;33m' # Yellow
PURPLE='\033[0;35m' # Purple
STD='\033[0m'       # Text Reset
# ----------------------------------
# * Step #1-2: Define Function
# ----------------------------------
bold() {
    echo -e "$PURPLE > $(tput bold)" "$*" "$(tput sgr0) $STD"
}
succ() {
    echo -e "$GREEN [Success] $* ! $STD"
}
err() {
    echo -e "$*" >&2
}
ask() {
    echo -e "$YELLOW\c"
    echo -e "$STD\c"
}
# installfunc [name] [doing code]
installfunc() {
    if [ ! -d "/Applications/$1.app" ] && [ -z "$(command -v "$1")" ]; then
        bold Start install "$1"
        echo -e "$YELLOW\c"
        [ "$DRY_MODE" = "false" ] && "${@:2}"
        echo -e "$STD"

    else
        succ "👌 $1 is ready in your mac"
    fi
}
# ----------------------------------
# * Step #2: main
# ----------------------------------
cat >&2 <<EOF
--------------------------------------------------
  _____ ______   ____  ____  ______    ___  ____  
 / ___/|      | /    ||    \|      |  /  _]|    \ 
(   \_ |      ||  o  ||  D  )      | /  [_ |  D  )
 \__  ||_|  |_||     ||    /|_|  |_||    _]|    / 
 /  \ |  |  |  |  _  ||    \  |  |  |   [_ |    \ 
 \    |  |  |  |  |  ||  .  \ |  |  |     ||  .  \\
  \___|  |__|  |__|__||__|\_| |__|  |_____||__|\_|

--------------------------------------------------
 Usage: 
  $(basename "${BASH_SOURCE[0]}") [--dry-run] [--version]
 Description:
  lctech - 安裝工作環境相關程式
           請先確認 mail 及 Git 權限
 Command:
  -d,--dry-run   不安裝模式
  -v,--version   版本
-------------------------------------------------- 
EOF
if [ "$FLAG" = "-v" ] || [ "$FLAG" = "--version" ]; then
    DRY_MODE=true
    echo -e "$PURPLE $(basename "${BASH_SOURCE[0]}") Version : $VERSION $STD"
    exit 0
fi
if [ "$FLAG" = "-d" ] || [ "$FLAG" = "--dry-run" ]; then
    DRY_MODE=true
    echo -e "$PURPLE > DRY_MODE $STD"
fi

# init
read -rp "  ➡️ Git Account: " GITACCOUNT
read -rp "  ➡️ Git PAT: " GITPAT

# homebrew
installfunc brew /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# homebrew/cask
if ! brew tap | grep -q "homebrew/cask" ; then
brew tap caskroom/cask
fi
export HOMEBREW_NO_AUTO_UPDATE=1
# mas
installfunc mas brew install mas
# xcode
installfunc Xcode mas install 497799835
# HTTPBot
installfunc HTTPBot mas install 1232603544
# Line
installfunc LINE mas install 539883307
# Trello
installfunc Trello mas install 1278508951
# Docker
installfunc docker brew cask install docker
# Slack
installfunc Slack brew cask install slack
# notion
installfunc Notion brew install --cask notion
# GCP SDK
installfunc google-cloud-sdk google-chrome brew install google-cloud-sdk
# tableplus
installfunc tableplus brew install --cask tableplus
# zeplin
installfunc zeplin brew install --cask zeplin
# outline
installfunc outline mas install 1356178125

# .netrc
bold Set you .netrc file
migrate_netrc() {
    cat <<EOF >>~/.netrc
machine github.com
login $GITACCOUNT
password $GITPAT
EOF
}
if [ -f ~/.netrc ]; then
    if ! grep -q "machine github.com" ~/.netrc; then
        echo "==> have netrc , help you backup origin file to [./netrc.bk]"
        cp ~/.netrc ~/.netrc.bk
        migrate_netrc
    fi
else
    touch ~/.netrc
    migrate_netrc
fi
succ 🆗 migrate .netrc is OK

# .npmrc
bold Set you .npmrc file
migrate_npmrc() {
    cat <<EOF >>~/.npmrc
//npm.pkg.github.com/:_authToken=$GITPAT
@jkforum:registry=https://npm.pkg.github.com/jkforum
EOF
}
if [ -f ~/.npmrc ]; then
    if ! grep -q "@jkforum:registry" ~/.npmrc; then
        echo "==> have npmrc , help you backup origin file to [./npmrc.bk]"
        cp ~/.npmrc ~/.npmrc.bk
        migrate_npmrc
    fi
else
    touch ~/.npmrc
    migrate_npmrc
fi
succ 🆗 migrate .npmrc is OK

# vscode https://code.visualstudio.com/download
installfunc vscode wget https://vscode.cdn.azure.cn/stable/e5a624b788d92b8d34d1392e4c4d9789406efe8f/VSCode-darwin-stable.zip
if [ -f ./VSCode-darwin-stable.zip ]; then
    open  ./VSCode-darwin-stable.zip
    cp -rf ./Visual Studio Code.app /Application
fi

# google-chrome
installfunc google-chrome brew install google-chrome
# google-chrome grpc util
cd ~/Library/Application\ Support/
DIR="Google/Chrome/Default/Extensions/ddamlpimmiapbcopeoifjfmoabdbfbjj/"
[ -d "${DIR}" ] || open -a "Google Chrome" https://chrome.google.com/webstore/detail/grpc-web-developer-tools/ddamlpimmiapbcopeoifjfmoabdbfbjj\?utm_source\=chrome-ntp-icon &

succ "🚀 MAC Install is done ."
exit 0
