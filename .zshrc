# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                                                                            ║
# ║       ________  ________  ___  ___  _______   ___       ___                ║
# ║      |\_____  \|\   ____\|\  \|\  \|\  ___ \ |\  \     |\  \               ║
# ║       \|___/  /\ \  \___|\ \  \\\  \ \   __/|\ \  \    \ \  \              ║
# ║           /  / /\ \_____  \ \   __  \ \  \_|/_\ \  \    \ \  \             ║
# ║          /  /_/__\|____|\  \ \  \ \  \ \  \_|\ \ \  \____\ \  \____        ║
# ║         |\________\____\_\  \ \__\ \__\ \_______\ \_______\ \_______\      ║
# ║          \|_______|\_________\|__|\|__|\|_______|\|_______|\|_______|      ║
# ║                   \|_________|                                             ║
# ║                                                                            ║
# ║      xn--gckvb8fzb.com * github.com/mrusme * marius@xn--gckvb8fzb.com      ║
# ║                                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝
# zmodload zsh/zprof

export ZSH_TMUX_AUTOSTART=true
[[ "$USER" == "root" ]] && export ZSH_TMUX_AUTOSTART=false
export DOT_ZSHRC="$HOME/.zshrc"
export DOT_ZSHRC_VERSION="0.32"

type /usr/local/bin/zsh > /dev/null \
&& export SHELL=/usr/local/bin/zsh

export OS=$(uname)
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export XDG_CONFIG_HOME=$HOME/.config

export ICONS_PATH="$HOME/projects/github/arcticons/icons/white"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Tmux Magic (via SSH)                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

type tmux > /dev/null \
&& [[ -n $SSH_CONNECTION ]] \
&& [[ -z $TMUX ]] \
&& [[ "$USER" != "root" ]] \
&& tmux new-session -A -s ssh && exit


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ General config                                                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=100000
export HISTFILESIZE=200000
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# export TERM=xterm-16color
export TERM=xterm-256color
export COLUMNS=80

export EDITOR=vim
type nvim > /dev/null \
&& export EDITOR=nvim

if [[ -n $SSH_CONNECTION ]]; then
  export BROWSER=w3m
else
  if [[ "$OS" = "Linux" ]]
  then
    export BROWSER=firefox
  elif [[ "$OS" = "Darwin" ]]
  then
    export BROWSER=open
  fi
fi

export SSH_KEY_PATH="$HOME/.ssh/id_rsa"

# Enable Erlang/IEx shell history
export ERL_AFLAGS="-kernel shell_history enabled"

# IPFS
export IPFS_PATH="$HOME/.ipfs"

# Firefox
#export GDK_BACKEND="wayland"
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2="1"

# Qt
export QT_STYLE_OVERRIDE=kvantum

# https://github.com/oz/tz/
export TZ_LIST="Pacific/Honolulu;America/Panama;America/New_York;Etc/UTC;\
Europe/Berlin;Asia/Bangkok;Asia/Tokyo;Australia/Melbourne"

# https://github.com/mrusme/zeit
export ZEIT_DB="$HOME/.zeit.db"

# https://github.com/mrusme/geld
export GELD_DB="$HOME/.geld.db"

# Import color scheme via wal
#[[ "$OS" = "Linux" ]] \
#&& type wal > /dev/null && (wal -r &)


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Secrets                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export DOT_SECRETS="$HOME/.secrets"
[[ -e "$DOT_SECRETS" ]]\
&& source "$DOT_SECRETS"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ $PATH                                                                      ║
# ╚════════════════════════════════════════════════════════════════════════════╝

[[ "$OS" = "Darwin" ]] \
&& eval "$(/usr/libexec/path_helper -s)"

# /usr/local/* (Homebrew, etc)
[[ "$OS" = "Darwin" ]] \
&& export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/opt/binutils/bin:$PATH"\
&& export MANPATH="/usr/local/man:$MANPATH"

# Cargo (Rust)
[[ -d "$HOME/.cargo/bin" ]] \
&& export PATH="$HOME/.cargo/bin:$PATH"

[[ -e "$HOME/.cargo/env" ]] \
&& source "$HOME/.cargo/env"

# Go
[[ "$OS" = "Darwin" ]] \
&& export GOROOT="/usr/local/opt/go/libexec"
go env -w GOPATH="$HOME/.go"
export PATH=$HOME/.go/bin:$PATH

# Python virtualenv
export VIRTUALENVWRAPPER_PYTHON="$(which python3)"
export WORKON_HOME="$HOME/.virtualenvs"
function activate.virtualenv {
  type virtualenvwrapper_lazy.sh > /dev/null \
  && source "$(which virtualenvwrapper_lazy.sh)" \
  && workon | grep local > /dev/null \
  && workon local \
  && echo "Activated local." \
  || echo "Could not load virtualenvwrapper."
}

export PYTHON_MAJOR_MINOR="$(python3 \
  --version | sed -nr 's/.*([0-9]+\.[0-9]+)\..*/\1/p')"

[[ -d "$HOME/Library/Python/$PYTHON_MAJOR_MINOR/bin" ]] \
&& export PATH="$HOME/Library/Python/$PYTHON_MAJOR_MINOR/bin:$PATH"

# Ruby
[[ "$OS" = "Darwin" ]] \
&& export PATH="/usr/local/Cellar/ruby/$(ls -1 /usr/local/Cellar/ruby/ \
                                        | sort \
                                        | tail -n 1)/bin:$PATH"

# Rubygems
type gem > /dev/null \
&& export PATH="$(gem env \
              | grep "EXECUTABLE DIRECTORY" \
              | awk -F ': ' '{ print $2 }'):$PATH" \
&& export PATH="$(gem env \
              | grep "USER INSTALLATION DIRECTORY" \
              | awk -F ': ' '{ print $2 }')/bin:$PATH"

# NPM
export NPM_PACKAGES="${HOME}/.local/lib64/node_modules"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# Wayland
if [[ "$OS" = "Linux" ]]
then
  alias sway-launch='dbus-launch --exit-with-session sway'
  if test -z "${XDG_RUNTIME_DIR}"
  then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"
    then
      mkdir "${XDG_RUNTIME_DIR}"
      chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
  fi
  export GTK2_RC_FILES="$HOME/.themes/Kripton/gtk-2.0/gtkrc"
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ ZSH                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export ZSH="$HOME/.oh-my-zsh"
# [[ -e $ZSH ]] || \
# ([[ "$USER" != "root" ]] && sh -c "$(curl -fsSL \
#     https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)")

ZSH_THEME="geometry-zsh/geometry"
[[ "$USER" == "root" ]] && GEOMETRY_SEPARATOR=" root"

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

ZSH_AUTOSUGGESTIONS="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}\
/plugins/zsh-autosuggestions"

# [[ ! -d $ZSH_AUTOSUGGESTIONS ]] \
# && type git > /dev/null \
# && git clone https://github.com/zsh-users/zsh-autosuggestions \
# ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# [[ -d $ZSH_AUTOSUGGESTIONS && $(find "$ZSH_AUTOSUGGESTIONS/.git" \
#   -maxdepth 0 -type d -mmin +1440 | wc -l | tr -d '[:space:]') == "0" ]] \
# || git -C $ZSH_AUTOSUGGESTIONS pull

[[ "$OS" = "Darwin" ]] && plugins=(tmux docker encode64 extract git git-flow \
  gpg-agent history ssh-agent urltools \
  zsh-autosuggestions mosh fzf terraform taskwarrior thefuck brew macos)
[[ "$OS" = "Linux" && "$USER" != "root" ]]  && plugins=(docker encode64 extract git git-flow \
  gpg-agent history ssh-agent urltools \
  zsh-autosuggestions mosh fzf terraform taskwarrior thefuck)
# Disabled: gcloud, nvm, virtualenvwrapper

[[ -e "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

fpath=(
  /usr/local/share/zsh-completions
  /usr/local/share/zsh/site-functions
  $fpath
)

eval "$(fasd --init \
posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Aliases                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

alias ..='cd ..'
alias ...='cd ../../'
alias re='cd -'

alias cat=bat

type exa > /dev/null \
&& unalias ls la ll l lsa &> /dev/null \
&& alias ls='exa --time-style=long-iso --git --icons --binary -lg' \
&& alias la='exa --time-style=long-iso --git --icons --binary -la' \
&& alias ll='exa --time-style=long-iso --git --icons --octal-permissions --binary --changed -lahHgnuU' \
&& alias l='exa --time-style=long-iso --git --icons --binary -l --no-time'

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

type xdg-open > /dev/null \
&& alias open='xdg-open'

type taskwarrior-tui > /dev/null \
&& alias todo='taskwarrior-tui'

alias fucking=sudo

alias my-ip="curl http://ipecho.net/plain; echo"

alias git-crypt-add-myself="git-crypt add-gpg-user \
4D3899AF73E7F5FE9B39C822272ED814BF63261F"
alias gpa='git push all "$(git_current_branch)"'
gtd() {
  git tag -d "$1"
  git push --delete origin "$1"
}

alias jrnl='cd $HOME/[Pp]rojects/@mrusme/xn--gckvb8fzb.com/content/'
alias bookmarks='vim $HOME/[Pp]rojects/@mrusme/xn--gckvb8fzb.com/content/bookmarks/index.md'
alias notes='cd $HOME/[Cc]loud/notes/'
alias cheatsheet-vim='vim $HOME/[Cc]loud/notes/tools/vim.md'


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Bound keys                                                                 ║
# ╚════════════════════════════════════════════════════════════════════════════╝

[[ "$OS" = "Darwin" ]] \
&& bindkey "\e[1;3C" forward-word \
&& bindkey "\e[1;3D" backward-word


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ motd                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

DOT_MOTD="$HOME/.motd"
[[ -e "$DOT_MOTD" ]] && source "$DOT_MOTD"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║    __ __    __                                                             ║
# ║   / // /__ / /__  ___ _______                                              ║
# ║  / _  / -_) / _ \/ -_) __(_-<                                              ║
# ║ /_//_/\__/_/ .__/\__/_/ /___/                                              ║
# ║           /_/                                                              ║
# ╚════════════════════════════════════════════════════════════════════════════╝


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Poor-man's aptitude                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if [ "$OS" = "Darwin" ]
then
  function aptitude {
    if [ -z "$1" ]; then
      echo "Usage: aptitude <action> [options] ..."
    else
      case $1 in
        install)     brew install "${@:2}";;
        remove)      brew uninstall "${@:2}";;
        purge)       brew uninstall "${@:2}"; brew cleanup;;
        update)      brew update "${@:2}";;
        upgrade)     brew upgrade "${@:2}";;
        safe-upgrade)brew upgrade "${@:2}";;
        full-upgrade)brew upgrade "${@:2}";;
        search)      brew search "${@:2}";;
        show)        brew info "${@:2}";;
        clean)       brew cleanup "${@:2}";;
        reinstall)   brew uninstall "${@:2}"; brew cleanup; brew install "${@:2}";;
        *)           echo "aptitude: '$1' - unknown action" ;;
      esac
    fi
  }
elif [[ "$OS" = "Linux" && "$(uname -a | grep -i gentoo)" ]]
then
  function aptitude {
    if [ -z "$1" ]; then
      echo "Usage: aptitude <action> [options] ..."
    else
      case $1 in
        install)     emerge -av --keep-going=y "${@:2}";;
        remove)      emerge -cav "${@:2}";;
        purge)       emerge -Cav "${@:2}";;
        update)      emerge --sync "${@:2}";;
        upgrade)     emerge --ask --update --deep --changed-use --verbose-conflicts --keep-going=y "${@[2]:-@world}";;
        safe-upgrade)emerge -avu --keep-going=y "${@[2]:-@world}";;
        full-upgrade)emerge -avuND --keep-going=y --with-bdeps=y "${@[2]:-@world}";;
        search)      emerge -s "${@:2}";;
        show)        equery meta "${@:2}";;
        clean)       emerge -avc "${@:2}";;
        reinstall)   emerge -ave "${@:2}";;
        *)           echo "aptitude: '$1' - unknown action" ;;
      esac
    fi
  }
elif [[ "$OS" = "Linux" && "$(type pacman > /dev/null)" ]]
then
  function aptitude {
    if [ -z "$1" ]; then
      echo "Usage: aptitude <action> [options] ..."
    else
      case $1 in
        install)     pacman -S "${@:2}";;
        remove)      pacman -R "${@:2}";;
        purge)       pacman -Rs "${@:2}";;
        update)      pacman -y -y "${@:2}";;
        upgrade)     pacman -Syu "${@:2}";;
        safe-upgrade)pacman -Syu "${@:2}";;
        full-upgrade)pacman -Syu "${@:2}";;
        search)      pacman -Ss "${@:2}";;
        show)        pacman -Si "${@:2}";;
        clean)       pacman -Scc "${@:2}";;
        reinstall)   pacman -S "${@:2}";;
        *)           echo "aptitude: '$1' - unknown action" ;;
      esac
    fi
  }
fi

if [[ "$OS" = "Darwin" ]] \
|| [[ "$OS" = "Linux" && "$(uname -a | grep -i gentoo)" ]] \
|| type pacman > /dev/null
then
  _aptitude()
  {
      local cur=${COMP_WORDS[COMP_CWORD]}
      COMPREPLY=( $(compgen -W "install remove purge update upgrade \
                                safe-upgrade full-upgrade search show \
                                clean reinstall" -- $cur) )
  }
fi
alias apt='aptitude'

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
    openssl pkcs12 -export -inkey "${1}" -in "${2}" -certfile "${3}" -out "${4}"
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
# ║ pushover                                                                   ║
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
  if [ -n "${value}" ]; then
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
  echo "$response"
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
    echo "CURL is unset, empty, or does not point to curl executable." >&2
    echo "This script requires curl!" >&2
    return 1
  fi

  devices="$(echo "${devices}" | xargs -n1 | sort -u | uniq)"

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
# ║ dotfiles-update-remote                                                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

[[ "$OS" = "Darwin" ]] \
&& export DOTFILES="$HOME/Projects/@mrusme/dotfiles"
[[ "$OS" = "Linux" ]] \
&& export DOTFILES="$HOME/projects/@mrusme/dotfiles"

[[ "$OS" = "Darwin" ]] \
&& subldir=$HOME/Library/Application\ Support/Sublime\ Text\ 3
[[ "$OS" = "Linux" ]] \
&& subldir=$XDG_CONFIG_HOME/sublime-text

function dotfiles-update-remote() {
  cp "$HOME/.zshrc" "$DOTFILES/.zshrc"
  cp "$HOME/.tmux.conf" "$DOTFILES/.tmux.conf"
  cp "$HOME/.tmux.cheatsheet" "$DOTFILES/.tmux.cheatsheet"
  cp "$HOME/.motd" "$DOTFILES/.motd"
  cp "$HOME/.gitconfig" "$DOTFILES/.gitconfig"
  cp "$HOME/.mbsyncrc" "$DOTFILES/.mbsyncrc"
  cp "$HOME/.wallpaper" "$DOTFILES/.wallpaper"

  cp "$HOME/.mozilla/firefox/"*".default-release/chrome/userChrome.css"\
      "$DOTFILES/.mozilla/firefox/default/chrome/userChrome.css"

  cp "$XDG_CONFIG_HOME/alacritty/alacritty.yml"\
     "$DOTFILES/alacritty/alacritty.yml"

  cp "$XDG_CONFIG_HOME/neomutt/neomuttrc" "$DOTFILES/neomutt/neomuttrc"
  cp "$XDG_CONFIG_HOME/neomutt/accounts/"* "$DOTFILES/neomutt/accounts/"

  cp "$XDG_CONFIG_HOME/nvim/init.vim" "$DOTFILES/nvim/init.vim"
  cp "$XDG_CONFIG_HOME/nvim/colors/"*.vim "$DOTFILES/nvim/colors/"
  cp "$XDG_CONFIG_HOME/nvim/autoload/lightline/colorscheme/"*.vim\
    "$DOTFILES/nvim/autoload/lightline/colorscheme/"

  cp "$XDG_CONFIG_HOME/lf/"* "$DOTFILES/lf/"

  cp "$XDG_CONFIG_HOME/wtf/config.yml" "$DOTFILES/wtf/config.yml"

  # Phasing out Sublime Text as I'm not using it anymore
  #
  # cp $subldir/Packages/User/Package\ Control.sublime-settings\
  #   "$DOTFILES/st3/Package Control.sublime-settings"
  # cp $subldir/Packages/User/Preferences.sublime-settings\
  #   "$DOTFILES/st3/Preferences.sublime-settings"
  # cp $subldir/Packages/User/LSP.sublime-settings\
  #   "$DOTFILES/st3/LSP.sublime-settings"
  # cp $subldir/Packages/User/vap0r-*.tmTheme\
  #   "$DOTFILES/st3/"

  if [ "$OS" = "Darwin" ]
  then
    brew ls --formula -1 --full-name > "$DOTFILES/brew/ls_-1"
    brew ls --cask -1 --full-name > "$DOTFILES/brew/cask_ls_-1"
  fi
  if [ "$OS" = "Linux" ]
  then
    /usr/bin/find /usr/local/bin -type f -exec sh -c '
      case $( file -bi "$1" ) in (*/x-shellscript*) exit 0; esac
      exit 1' sh {} \; -print | while read -r scriptfile
      do
        cp "$scriptfile" "$DOTFILES/usr/local/bin/"
      done

    cp "$XDG_CONFIG_HOME/dunst/dunstrc" "$DOTFILES/dunst/dunstrc"

    cp "$XDG_CONFIG_HOME/mpd/mpd.conf" "$DOTFILES/mpd/mpd.conf"

    cp "$XDG_CONFIG_HOME/ncmpcpp/config" "$DOTFILES/ncmpcpp/config"

    cp "$XDG_CONFIG_HOME/sway/config" "$DOTFILES/sway/config"

    cp "$XDG_CONFIG_HOME/swaylock/config" "$DOTFILES/swaylock/config"

    cp "$XDG_CONFIG_HOME/task/taskrc" "$DOTFILES/task/taskrc"

    cp "$XDG_CONFIG_HOME/waybar/"* "$DOTFILES/waybar/"

    cp "$XDG_CONFIG_HOME/wofi/"* "$DOTFILES/wofi/"
  fi

  cargo install --list > "$DOTFILES/cargo/install_--list"
  npm list -g --depth=0 > "$DOTFILES/npm/list_-g_--depth_0"
  # go list '...' | rg '^github.com' > "$DOTFILES/go/list_github.com"
  git -C "$DOTFILES" commit -a -S
  return 0
}

function dotfiles-update-local() {
  echo -n "are you sure? (y/n) "
  read -r confirmation

  [[ $confirmation != "y" ]] && return 1

  cp "$DOTFILES/.zshrc" "$HOME/.zshrc"
  cp "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
  cp "$DOTFILES/.tmux.cheatsheet" "$HOME/.tmux.cheatsheet"
  cp "$DOTFILES/.motd" "$HOME/.motd"
  cp "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
  cp "$DOTFILES/.mbsyncrc" "$HOME/.mbsyncrc"
  cp "$DOTFILES/.wallpaper" "$HOME/.wallpaper"

  mkdir -p "$XDG_CONFIG_HOME/alacritty"
  cp "$DOTFILES/alacritty/alacritty.yml"\
     "$XDG_CONFIG_HOME/alacritty/alacritty.yml"

  mkdir -p "$XDG_CONFIG_HOME/neomutt/accounts"
  cp "$DOTFILES/neomutt/neomuttrc" "$XDG_CONFIG_HOME/neomutt/neomuttrc"

  mkdir -p "$XDG_CONFIG_HOME/nvim/colors"
  mkdir -p "$XDG_CONFIG_HOME/nvim/autoload/lightline/colorscheme"
  cp "$DOTFILES/nvim/init.vim" "$XDG_CONFIG_HOME/nvim/init.vim"
  cp "$DOTFILES/nvim/colors/"*.vim "$XDG_CONFIG_HOME/nvim/colors/"
  cp "$DOTFILES/nvim/autoload/lightline/colorscheme/"*.vim\
     "$XDG_CONFIG_HOME/nvim/autoload/lightline/colorscheme/"

  mkdir -p "$XDG_CONFIG_HOME/lf"
  cp "$DOTFILES/lf/"* "$XDG_CONFIG_HOME/lf/"

  mkdir -p "$XDG_CONFIG_HOME/wtf"
  cp "$DOTFILES/wtf/config.yml" "$XDG_CONFIG_HOME/wtf/config.yml"

  # Phasing out Sublime Text as I'm not using it anymore
  #
  # cp "$DOTFILES/st3/Package Control.sublime-settings"\
  #    $subldir/Packages/User/Package\ Control.sublime-settings
  # cp "$DOTFILES/st3/Preferences.sublime-settings"\
  #    $subldir/Packages/User/Preferences.sublime-settings
  # cp "$DOTFILES/st3/LSP.sublime-settings"\
  #    $subldir/Packages/User/LSP.sublime-settings
  # cp "$DOTFILES/st3/vap0r-*.tmTheme"
  #    $subldir/Packages/User/

  if [ "$OS" = "Linux" ]
  then
    cp "$DOTFILES/usr/local/bin/"* /usr/local/bin/

    mkdir -p "$XDG_CONFIG_HOME/dunst" 
    cp "$DOTFILES/dunst/dunstrc" "$XDG_CONFIG_HOME/dunst/dunstrc" 

    mkdir -p "$XDG_CONFIG_HOME/mpd" 
    cp "$DOTFILES/mpd/mpd.conf" "$XDG_CONFIG_HOME/mpd/mpd.conf" 

    mkdir -p "$XDG_CONFIG_HOME/ncmpcpp" 
    cp "$DOTFILES/ncmpcpp/config" "$XDG_CONFIG_HOME/ncmpcpp/config" 

    mkdir -p "$XDG_CONFIG_HOME/sway" 
    cp "$DOTFILES/sway/config" "$XDG_CONFIG_HOME/sway/config" 

    mkdir -p "$XDG_CONFIG_HOME/swaylock" 
    cp "$DOTFILES/swaylock/config" "$XDG_CONFIG_HOME/swaylock/config" 

    mkdir -p "$XDG_CONFIG_HOME/task" 
    cp "$DOTFILES/task/taskrc" "$XDG_CONFIG_HOME/task/taskrc" 

    mkdir -p "$XDG_CONFIG_HOME/waybar" 
    cp "$DOTFILES/waybar/"* "$XDG_CONFIG_HOME/waybar/" 

    mkdir -p "$XDG_CONFIG_HOME/wofi" 
    cp "$DOTFILES/wofi/"* "$XDG_CONFIG_HOME/wofi/" 
  fi
  return 0
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ update-tools                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function update-tools() {
  echo "Updating Rust tools ..."
  cargo install-update -a

  echo ""

  echo "Updating Go tools ..."
  /bin/ls -1 ~/.go/bin/ \
    | while read bin; do go version -m ~/.go/bin/$bin \
    | grep '^[[:space:]]path' \
    | awk '{ print $2 }' \
    | grep '^github.com' \
    | sort \
    | uniq \
    | xargs -I{} go install {}@latest; done

  echo ""
  echo "Tools updated"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ terminal-colors                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function terminal-colors() {
  if [[ $1 == "dark" ]]
  then
    sed -i=.previous 's/\*light$/\*dark/g' "$XDG_CONFIG_HOME/alacritty/alacritty.yml"
  else
    sed -i=.previous 's/\*dark$/\*light/g' "$XDG_CONFIG_HOME/alacritty/alacritty.yml"
  fi
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ git-add-all-remote                                                         ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function git-add-all-remote() {
  if git remote | grep -q '^all$'
  then
    echo "Remote 'all' already exists!"
    return 1
  else
    git remote | while read -r remote
    do
      git config --add remote.all.url "$(git remote get-url --all $remote)"
      echo "Remote $remote added to 'all'"
    done
    return 0
  fi
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ git-find-modified-repos                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function git-find-modified-repos() {
  find ./ -type d -name '.git' | while read -r dir
  do 
    repo=$(dirname "$dir")
    repostatus=$(git -C "$repo" status -s)
    if [[ -n "$repostatus" ]]
    then 
      echo "$repo"
    fi 
  done
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Offline Wikipedia (https://xn--gckvb8fzb.com/lets-take-wikipedia-offline)  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export WIKIPEDIA_INDEX_ID="wikipedia"
export WIKIPEDIA_METASTORE_URI="file:///home/mrus/projects/@mrusme/ulpia/wikipedia"
export DISABLE_QUICKWIT_TELEMETRY=1

function wikipedia() {
  search="$*"
  query="title:\"$search\""
  json=$(quickwit index search \
    --index-id "$WIKIPEDIA_INDEX_ID" \
    --metastore-uri "$WIKIPEDIA_METASTORE_URI" \
    --query "$query" \
  )

  numHits=$(printf '%s' "$json" | jq '.numHits')
  if [[ $numHits == 0 ]]
  then
    echo "Nothing found, sorry."
    return 1
  fi

  selection=$(printf '%s' "$json" \
    | jq \
      --raw-output \
      '.hits[].title[0]' \
    | /bin/cat -n \
    | fzf \
      --no-multi \
      -0 \
      -q "$search" \
      --with-nth 2.. \
  )

  if [[ $? == 130 ]]
  then
    return 2
  fi

  index=$(echo "$selection" \
    | awk '{ print $1-1 }' \
  )

  if [[ -n "$index" ]]
  then
    printf '%s' "$json" \
      | jq \
        --raw-output \
        ".hits[$index].section_texts | join(\"\n\n\n\")" \
        | pandoc \
          -f mediawiki \
          -t markdown_strict \
          | glow - -p 
  else
    echo "Err?"
    return 3
  fi
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Math functions                                                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function calc-x-percent-of-y() {
  eva "($1 / 100) * $2" | tr -d ' '
}

function calc-percentage-x-of-y() {
  eva "($1 / $2) * 100" | tr -d ' '
}

function calc-percentage-change-x-to-y() {
  eva "(($2 - $1) / $1) * 100" | tr -d ' '
}

function convert-fahrenheit-to-celsius() {
  eva "($1 - 32) * (5/9)" | tr -d ' '
}

function convert-celsius-to-fahrenheit() {
  eva "($1 * (9/5)) + 32" | tr -d ' '
}

function convert-in-to-cm() {
  eva "$1 * 2.54" | tr -d ' '
}

function convert-cm-to-in() {
  eva "$1 / 2.54" | tr -d ' '
}

function convert-ft-to-cm() {
  eva "$1 * 30.48" | tr -d ' '
}

function convert-cm-to-ft() {
  eva "$1 / 30.48" | tr -d ' '
}

function convert-ft-in-to-m() {
  eva "$1 * 30.48 + $2 * 2.54" | tr -d ' '
}

function convert-cm-to-ft-in() {
  ft=$(eva "floor($1 / 2.54) / 12" | tr -d ' ')
  in=$(eva "($1 / 2.54) - 12 * $ft" | tr -d ' ')
  echo "$ft ft $in in"
}

function convert-kn-to-kmh() {
  eva "$1 * 1.852" | tr -d ' '
}

function convert-kmh-to-kn() {
  eva "$1 / 1.852" | tr -d ' '
}

function convert-mph-to-kmh() {
  eva "$1 * 1.609344" | tr -d ' '
}

function convert-kmh-to-mph() {
  eva "$1 / 1.609344" | tr -d ' '
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Stoicism                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

fortune stoic
echo ""


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Stuff other programs dare to append goes here                              ║
# ╚════════════════════════════════════════════════════════════════════════════╝
#
# ...

# zprof
