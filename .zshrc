# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                                                                            ║
# ║                            ┏━━━━┓ ┏━━━┓ ┏━┓ ┏━┓                            ║
# ║                            ┗━━┓ ┃ ┃┏━━┛ ┃ ┃ ┃ ┃                            ║
# ║                              ┏┛┏┛ ┃┗━━┓ ┃ ┗━┛ ┃                            ║
# ║                             ┏┛┏┛  ┗━━┓┃ ┃ ┏━┓ ┃                            ║
# ║                            ┏┛ ┗━┓ ┏━━┛┃ ┃ ┃ ┃ ┃                            ║
# ║                            ┗━━━━┛ ┗━━━┛ ┗━┛ ┗━┛                            ║
# ║                                                                            ║
# ║      xn--gckvb8fzb.com * github.com/mrusme * marius@xn--gckvb8fzb.com      ║
# ║                                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝
# zmodload zsh/zprof

export ZSH_TMUX_AUTOSTART=true
export DOT_ZSHRC="$HOME/.zshrc"
export DOT_ZSHRC_VERSION="0.31"

type /usr/local/bin/zsh > /dev/null \
&& export SHELL=/usr/local/bin/zsh


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Tmux Magic (via SSH)                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

type tmux > /dev/null \
&& [[ -n $SSH_CONNECTION ]] \
&& [[ -z $TMUX ]] \
&& tmux new-session -A -s ssh && exit


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ General config                                                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export OS=$(uname)
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=100000
export HISTFILESIZE=200000
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# export TERM=xterm-16color
export TERM=xterm-256color

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR=vim
  export BROWSER=w3m
else
  export EDITOR=vim
  export BROWSER=w3m

  [[ $OS = "Darwin" ]] \
  && export EDITOR=vim \
  && export BROWSER=open
fi

export SSH_KEY_PATH="~/.ssh/id_rsa"

# Enable Erlang/IEx shell history
export ERL_AFLAGS="-kernel shell_history enabled"

# https://github.com/oz/tz/
export TZ_LIST='Pacific/Honolulu,America/Panama,America/New_York,Etc/UTC,Europe/Berlin,Asia/Bangkok,Asia/Tokyo,Australia/Melbourne'

# https://github.com/mrusme/zeit
export ZEIT_DB=~/.zeit.db

# https://github.com/mrusme/geld
export GELD_DB=~/.geld.db

# Import color scheme via wal
[[ $OS = "Linux" ]] \
&& type wal > /dev/null && (wal -r &)


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Secrets                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

DOT_SECRETS="$HOME/.secrets"
[[ -e $DOT_SECRETS ]]\
&& source $DOT_SECRETS


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ $PATH                                                                      ║
# ╚════════════════════════════════════════════════════════════════════════════╝

[[ $OS = "Darwin" ]] \
&& eval $(/usr/libexec/path_helper -s)

# /usr/local/* (Homebrew, etc)
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/opt/binutils/bin:$PATH
export MANPATH="/usr/local/man:$MANPATH"

# Cargo (Rust)
[[ -d "$HOME/.cargo/bin" ]] \
&& export PATH=$HOME/.cargo/bin:$PATH

[[ -e "$HOME/.cargo/env" ]] \
&& source $HOME/.cargo/env

# Go
[[ $OS = "Darwin" ]] \
&& export GOROOT=/usr/local/opt/go/libexec
go env -w GOPATH=$HOME/.go
export PATH=$HOME/.go/bin:$PATH

# Python virtualenv
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export WORKON_HOME=$HOME/.virtualenvs
function activate.virtualenv {
  type virtualenvwrapper_lazy.sh > /dev/null \
  && source $(which virtualenvwrapper_lazy.sh) \
  && workon | grep local > /dev/null \
  && workon local \
  && echo "Activated local." \
  || echo "Could not load virtualenvwrapper."
}

export PYTHON_MAJOR_MINOR=$(python3 --version | sed -nr 's/.*([0-9]+\.[0-9]+)\..*/\1/p')

[[ -d "$HOME/Library/Python/$PYTHON_MAJOR_MINOR/bin" ]] \
&& export PATH="$HOME/Library/Python/$PYTHON_MAJOR_MINOR/bin":$PATH

# NVM
export NVM_DIR="$HOME/.nvm"
function activate.nvm {
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
  # [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
}

# Ruby
[[ $OS = "Darwin" ]] \
&& export PATH=/usr/local/Cellar/ruby/$(ls -1 /usr/local/Cellar/ruby/ \
                                        | sort \
                                        | tail -n 1)/bin:$PATH

# Rubygems
type gem > /dev/null \
&& export PATH=$(gem env \
              | grep "EXECUTABLE DIRECTORY" \
              | awk -F ': ' '{ print $2 }'):$PATH \
&& export PATH=$(gem env \
              | grep "USER INSTALLATION DIRECTORY" \
              | awk -F ': ' '{ print $2 }')/bin:$PATH

# GCloud
function activate.gcloud {
  local gclouddir="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
  local gclouddir_path="$gclouddir/path.zsh.inc"
  local gclouddir_completion="$gclouddir/completion.zsh.inc"

  [[ -d $gclouddir ]] \
  || return

  export GOOGLE_API_KEY="no"
  export GOOGLE_DEFAULT_CLIENT_ID="no"
  export GOOGLE_DEFAULT_CLIENT_SECRET="no"

  # The next line updates PATH for the Google Cloud SDK.
  [[ -e $gclouddir_path ]] \
  && source $gclouddir_path

  # The next line enables shell command completion for gcloud.
  [[ -e $gclouddir_completion ]] \
  && source $gclouddir_completion
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ ZSH                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export ZSH=$HOME/.oh-my-zsh
[[ -e $ZSH ]] \
|| sh -c "$(curl -fsSL \
    https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ZSH_THEME="geometry-zsh/geometry"
CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
UPDATE_ZSH_DAYS=10
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="false"
DISABLE_UNTRACKED_FILES_DIRTY="false"

# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/usr/local/opt/zplug/repos

ZSH_AUTOSUGGESTIONS=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

[[ ! -d $ZSH_AUTOSUGGESTIONS ]] \
&& type git > /dev/null \
&& git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

[[ -d $ZSH_AUTOSUGGESTIONS && $(find "$ZSH_AUTOSUGGESTIONS/.git" -maxdepth 0 -type d -mmin +1440 | wc -l | tr -d '[:space:]') == "0" ]] \
|| git -C $ZSH_AUTOSUGGESTIONS pull

[[ $OS = "Darwin" ]] && plugins=(tmux docker encode64 extract git git-flow \
  gpg-agent history ssh-agent urltools \
  zsh-autosuggestions mosh fzf terraform taskwarrior thefuck brew osx)
[[ $OS = "Linux" ]]  && plugins=(tmux docker encode64 extract git git-flow \
  gpg-agent history ssh-agent urltools \
  zsh-autosuggestions mosh fzf terraform taskwarrior thefuck)

source $ZSH/oh-my-zsh.sh

fpath=(
  /usr/local/share/zsh-completions
  /usr/local/share/zsh/site-functions
  $fpath
)

eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Aptitude for MacOS & Gentoo                                                ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if [ $OS = "Darwin" ]
then
  function aptitude {
    if [ -z "$1" ]; then
      echo "Usage: aptitude <action> [options] ..."
    else
      OPTION=$1
      case $1 in
        install)     brew install ${@:2};;
        remove)      brew uninstall ${@:2};;
        purge)       brew uninstall ${@:2}; brew cleanup;;
        update)      brew update ${@:2};;
        upgrade)     brew upgrade ${@:2};;
        safe-upgrade)brew upgrade ${@:2};;
        full-upgrade)brew upgrade ${@:2};;
        search)      brew search ${@:2};;
        show)        brew info ${@:2};;
        clean)       brew cleanup ${@:2};;
        reinstall)   brew uninstall ${@:2}; brew cleanup; brew install ${@:2};;
        *)           echo "aptitude: '$1' - unknown action" ;;
      esac
    fi
  }
elif [[ $OS = "Linux" && "$(uname -a | grep -i gentoo)" ]]
then
  function aptitude {
    if [ -z "$1" ]; then
      echo "Usage: aptitude <action> [options] ..."
    else
      OPTION=$1
      case $1 in
        install)     emerge -av --keep-going=y ${@:2};;
        remove)      emerge -cav ${@:2};;
        purge)       emerge -Ccav ${@:2};;
        update)      emerge --sync ${@:2};;
        upgrade)     emerge -avu --keep-going=y ${@:2};;
        safe-upgrade)emerge -avu --keep-going=y ${@:2};;
        full-upgrade)emerge -avuND --keep-going=y --with-bdeps=y ${@:2};;
        search)      emerge -s ${@:2};;
        show)        emerge --info ${@:2};;
        clean)       emerge -avc ${@:2};;
        reinstall)   emerge -ave ${@:2};;
        *)           echo "aptitude: '$1' - unknown action" ;;
      esac
    fi
  }
elif [[ $OS = "Linux" && "$(type pacman > /dev/null)" ]]
then
  function aptitude {
    if [ -z "$1" ]; then
      echo "Usage: aptitude <action> [options] ..."
    else
      OPTION=$1
      case $1 in
        install)     pacman -S ${@:2};;
        remove)      pacman -R ${@:2};;
        purge)       pacman -Rs ${@:2};;
        update)      pacman -y -y ${@:2};;
        upgrade)     pacman -Syu ${@:2};;
        safe-upgrade)pacman -Syu ${@:2};;
        full-upgrade)pacman -Syu ${@:2};;
        search)      pacman -Ss ${@:2};;
        show)        pacman -Si ${@:2};;
        clean)       pacman -Scc ${@:2};;
        reinstall)   pacman -S ${@:2};;
        *)           echo "aptitude: '$1' - unknown action" ;;
      esac
    fi
  }
fi

if [[ $OS = "Darwin" ]] || [[ $OS = "Linux" && "$(uname -a | grep -i gentoo)" ]] || type pacman > /dev/null
then
  _aptitude()
  {
      local cur=${COMP_WORDS[COMP_CWORD]}
      COMPREPLY=( $(compgen -W "install remove purge update upgrade \
                                safe-upgrade full-upgrade search show \
                                clean reinstall" -- $cur) )
  }
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ OpenSSL                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function openssl-view-certificate () {
    openssl x509 -text -noout -in "${1}"
}

function openssl-view-csr () {
    openssl req -text -noout -verify -in "${1}"
}

function openssl-view-key () {
    openssl rsa -check -in "${1}"
}

function openssl-view-pkcs12 () {
    openssl pkcs12 -info -in "${1}"
}

function openssl-client () {
    openssl s_client -status -connect "${1}":443
}

# Convert PEM private key, PEM certificate and PEM CA certificate
# (used by nginx, Apache, and other openssl apps) to a PKCS12 file
# (typically for use with Windows or Tomcat)
function openssl-convert-pem-to-p12 () {
    openssl pkcs12 -export -inkey "${1}" -in "${2}" -certfile ${3} -out ${4}
}

# Convert a PKCS12 file to PEM
function openssl-convert-p12-to-pem () {
    openssl pkcs12 -nodes -in "${1}" -out "${2}"
}

# Check the modulus of a certificate (to see if it matches a key)
function openssl-check-certificate-modulus {
    openssl x509 -noout -modulus -in "${1}" | shasum -a 256
}

# Check the modulus of a key (to see if it matches a certificate)
function openssl-check-key-modulus {
    openssl rsa -noout -modulus -in "${1}" | shasum -a 256
}

# Check the modulus of a certificate request
function openssl-check-key-modulus {
  openssl req -noout -modulus -in "${1}" | shasum -a 256
}

# Encrypt a file (because zip crypto isn't secure)
function openssl-encrypt () {
    openssl aes-256-cbc -in "${1}" -out "${2}"
}

# Decrypt a file
function openssl-decrypt () {
    openssl aes-256-cbc -d -in "${1}" -out "${2}"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Pushover                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

__pushover_usage() {
  echo "pushover <options> <message>"
  echo " -c <callback>"
  echo " -d <device>"
  echo " -D <timestamp>"
  echo " -e <expire>"
  echo " -p <priority>"
  echo " -r <retry>"
  echo " -t <title>"
  echo " -T <TOKEN> (required if not in PUSHOVER_TOKEN env)"
  echo " -s <sound>"
  echo " -u <url>"
  echo " -U <USER> (required if not in PUSHOVER_USER env)"
  echo " -a <url_title>"
  return 1
}

__pushover_opt_field() {
  field=$1
  shift
  value="${*}"
  if [ ! -z "${value}" ]; then
    echo "-F \"${field}=${value}\""
  fi
}

__pushover_send_message() {
  local device="${1:-}"

  curl_cmd="\"${CURL}\" -s -S \
    ${CURL_OPTS} \
    -F \"token=${TOKEN}\" \
    -F \"user=${USER}\" \
    -F \"message=${message}\" \
    $(__pushover_opt_field device "${device}") \
    $(__pushover_opt_field callback "${callback}") \
    $(__pushover_opt_field timestamp "${timestamp}") \
    $(__pushover_opt_field priority "${priority}") \
    $(__pushover_opt_field retry "${retry}") \
    $(__pushover_opt_field expire "${expire}") \
    $(__pushover_opt_field title "${title}") \
    $(__pushover_opt_field sound "${sound}") \
    $(__pushover_opt_field url "${url}") \
    $(__pushover_opt_field url_title "${url_title}") \
    \"${PUSHOVER_URL}\""

  response="$(eval "${curl_cmd}")"
  echo $response
  # TODO: Parse response
  r="${?}"
  if [ "${r}" -ne 0 ]; then
    echo "${0}: Failed to send message" >&2
  fi

  return "${r}"
}

function pushover() {
  local CURL="$(which curl)"
  local PUSHOVER_URL="https://api.pushover.net/1/messages.json"
  local TOKEN=$PUSHOVER_TOKEN
  local USER=$PUSHOVER_USER
  local CURL_OPTS=""
  local device_aliases=""
  local devices="${devices} ${device}"
  local optstring="c:d:D:e:f:p:r:t:T:s:u:U:a:h"

  OPTIND=1
  while getopts ${optstring} c
  do
    case ${c} in
      c)
        callback="${OPTARG}"
        ;;
      d)
        devices="${devices} ${OPTARG}"
        ;;
      D)
        timestamp="${OPTARG}"
        ;;
      e)
        expire="${OPTARG}"
        ;;
      p)
        priority="${OPTARG}"
        ;;
      r)
        retry="${OPTARG}"
        ;;
      t)
        title="${OPTARG}"
        ;;
      k)
        TOKEN="${OPTARG}"
        ;;
      s)
        sound="${OPTARG}"
        ;;
      u)
        url="${OPTARG}"
        ;;
      U)
        USER="${OPTARG}"
        ;;
      a)
        url_title="${OPTARG}"
        ;;

      [h\?])
        __pushover_usage
        return 1
        ;;
    esac
  done
  shift $((OPTIND-1))

  if [ "$#" -lt 1 ]; then
    __pushover_usage
    return 1
  fi
  message="$*"

  if [ ! -x "${CURL}" ]; then
    echo "CURL is unset, empty, or does not point to curl executable. This script requires curl!" >&2
    return 1
  fi

  devices="$(echo ${devices} | xargs -n1 | sort -u | uniq)"

  if [ -z "${devices}" ]; then
    __pushover_send_message
    r=${?}
  else
    for device in ${devices}; do
      __pushover_send_message "${device}"
      r=${?}
      if [ "${r}" -ne 0 ]; then
        break;
      fi
    done
  fi
  return "${r}"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ zshrc management via gist                                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if [ -n $GITHUB_TOKEN ]
then
  if type gem > /dev/null
  then
    export PATH=$(gem env \
                   | grep "EXECUTABLE DIRECTORY" \
                   | awk -F ': ' '{ print $2 }'):$PATH

    if ! type gist > /dev/null
    then
      gem install gist
    fi

    # Workaround while waiting for
    # https://github.com/defunkt/gist/pull/232#issuecomment-468937574
    # GITHUB_TOKEN comes from .secrets
    echo $GITHUB_TOKEN > "$HOME/.gist"

    DOT_ZSHRC_DOT_GIST="$HOME/.zshrc.gist"
    [[ -e $DOT_ZSHRC_DOT_GIST ]] \
    || basename $(gist -l \
                  | grep '\.zshrc $' \
                  | awk '{ print $1 }') > $DOT_ZSHRC_DOT_GIST
    export ZSHRC_GIST=$(cat $DOT_ZSHRC_DOT_GIST)

    function zshrc-update-local() {
      ZSHRC_DIFFS=$(gist -r $ZSHRC_GIST \
                    | diff $DOT_ZSHRC - \
                    | wc -l \
                    | tr -d '[:space:]')
      [[ $ZSHRC_DIFFS -eq 0 ]] || (mv $DOT_ZSHRC "$DOT_ZSHRC.previous" \
                                  && gist -r $ZSHRC_GIST > $DOT_ZSHRC)
    }

    function zshrc-update-remote() {
      local nxtversion=$(echo $DOT_ZSHRC_VERSION | awk -F '.' '{ print ++$2 }')
      sed -i .previous \
        's/^export DOT_ZSHRC_VERSION="\([0-9]*\)\.\([0-9]*\)"$/export DOT_ZSHRC_VERSION="\1\.'$nxtversion'"/g' $DOT_ZSHRC \
      && gist -u "https://gist.github.com/$ZSHRC_GIST" $DOT_ZSHRC
    }
  fi
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ dotfiles                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export DOTFILES="$HOME/Projects/@mrusme/dotfiles"
function dotfiles-update-remote() {
  cp ~/.zshrc "$DOTFILES/.zshrc"
  cp ~/.tmux.conf "$DOTFILES/.tmux.conf"
  cp ~/.config/alacritty/alacritty.yml "$DOTFILES/alacritty.yml"
  cp ~/.config/nvim/init.vim "$DOTFILES/init.vim"
  cp ~/.motd "$DOTFILES/.motd"
  cp ~/.muttrc "$DOTFILES/.muttrc"
  cp ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings "$DOTFILES/Package Control.sublime-settings"
  cp ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings "$DOTFILES/Preferences.sublime-settings"
  cp ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/LSP.sublime-settings "$DOTFILES/LSP.sublime-settings"
  brew ls --formula -1 --full-name > "$DOTFILES/brew_ls_-1"
  brew ls --cask -1 --full-name > "$DOTFILES/brew_cask_ls_-1"
  cargo install --list > "$DOTFILES/cargo_install_--list"
  npm list -g --depth=0 > "$DOTFILES/npm_list_-g_--depth_0"
  go list '...' | rg '^github.com' > "$DOTFILES/go_list_github.com"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Functions                                                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function update-tools() {
  echo "Updating Rust tools ..."
  cargo install-update -a

  echo ""

  #echo "Updating Go tools ..."
  #go list '...' | rg '^github.com' | while read pkg; do echo "Updating $pkg ..."; go get -u "$pkg"; done

  #echo ""
  echo "Tools updated"
}

function terminal-colors() {
  if [[ $1 == "dark" ]]
  then
    sed -i .previous 's/\*light$/\*dark/g' ~/.config/alacritty/alacritty.yml
  else
    sed -i .previous 's/\*dark$/\*light/g' ~/.config/alacritty/alacritty.yml
  fi
}

function git-add-all-remote() {
  if git remote | grep -q '^all$'
  then
    echo "Remote 'all' already exists!"
    return 1
  else
    git remote | while read remote
    do
      git config --add remote.all.url $(git remote get-url --all "$remote")
      echo "Remote $remote added to 'all'"
    done
    return 0
  fi
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Aliases                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

alias ..='cd ..'
alias ...='cd ../../'
alias re='cd -'

alias cat=bat

type fd > /dev/null \
&& alias find='fd'

type exa > /dev/null \
&& alias ls='exa --git'

type btm > /dev/null \
&& alias top='btm'

type neomutt > /dev/null \
&& alias mutt=neomutt

type nvim > /dev/null \
&& alias vi=nvim \
&& alias vim=nvim

type fzf > /dev/null \
&& alias preview='fzf --preview="bat {} --color=always"'

type eva > /dev/null \
&& alias calc='eva'

type ghcal > /dev/null \
&& alias contributions='ghcal -u mrusme'

type gron > /dev/null \
&& alias json='gron'

type hexyl > /dev/null \
&& alias hex='hexyl'

type hyperfine > /dev/null \
&& alias benchmark='hyperfine'

type irssi > /dev/null \
&& alias irc='irssi'

alias fucking=sudo

alias my-ip="curl http://ipecho.net/plain; echo"

alias git-crypt-add-myself='git-crypt add-gpg-user DD89748CC9036BF1FB30DCAFC18062A7464CC561'

alias jrnl='cd ~/Projects/@mrusme/xn--gckvb8fzb.com/content/'


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Bound keys                                                                 ║
# ╚════════════════════════════════════════════════════════════════════════════╝

[[ $OS = "Darwin" ]] \
&& bindkey "\e[1;3C" forward-word \
&& bindkey "\e[1;3D" backward-word


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ motd                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

DOT_MOTD="$HOME/.motd"
[[ -e "$DOT_MOTD" ]] && source "$DOT_MOTD"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Stuff other programs dare to append goes here                              ║
# ╚════════════════════════════════════════════════════════════════════════════╝
#
# ...

# zprof
