#!/bin/zsh
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


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Basics                                                                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export OS="$(uname | tr '[:upper:]' '[:lower:]')"

function __is_available {
  prog="${1}"
  os="${2}"
  forcecheck="${3}"

  if [ "${os}" != "" ] && [ "${os}" != "${OS}" ]
  then 
    return 1
  fi

  if [ "${os}" = "" ] || [ "${os}" = "${OS}" ]
  then 
    if [ "${forcecheck}" != "true" ]
    then 
      case "${HOST}" in 
        "cbrspc7")
          return 0 
          ;;
        "d3lt4")
          return 0 
          ;;
      esac
    fi
  fi

  type "${prog}" > /dev/null 
  return "$?"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Exports                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

__is_available /usr/local/bin/zsh darwin \
&& export SHELL=/usr/local/bin/zsh

export ZSH_TMUX_AUTOSTART=true
[ "${USER}" = "root" ] \
&& export ZSH_TMUX_AUTOSTART="false"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export XCURSOR_THEME="Vimix-White"
export XCURSOR_SIZE="32"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DOWNLOAD_DIR="${HOME}/downloads"
export XDG_DESKTOP_DIR="${HOME}/desktop"
export XDG_TEMPLATES_DIR="${HOME}/"
export XDG_PUBLICSHARE_DIR="${HOME}/shared/public"
export XDG_DOCUMENTS_DIR="${HOME}/cloud/documents"
export XDG_MUSIC_DIR="${HOME}/cloud/music"
export XDG_PICTURES_DIR="${HOME}/cloud/photos"
export XDG_VIDEOS_DIR="${HOME}/cloud/videos"
# On change adjust `${XDG_CONFIG_HOME}/user-dirs.dirs` as well!

export ICONS_PATH="${HOME}/cloud/library/tools/icons/pixelarticons"

# if [ "$(lspci | grep -i geforce)" ]
# then
#   export WLR_NO_HARDWARE_CURSORS=1
# fi

# export ANTHROPIC_API_KEY="$(pass show anthropic/api-key)"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Tmux Magic (via SSH)                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

__is_available tmux \
&& [ -n "${SSH_CONNECTION}" ] \
&& [ -z "${TMUX}" ] \
&& [ "${USER}" != "root" ] \
&& tmux new-session -A -s ssh && exit


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ General config                                                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export HISTCONTROL="ignoredups:ignorespace"
export HISTSIZE="100000"
export HISTFILESIZE="200000"
export SAVEHIST="${HISTSIZE}"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# export TERM="xterm-16color"
export TERM="xterm-256color"
export COLUMNS="80"

export EDITOR="vim"
__is_available nvim \
&& export EDITOR="nvim"

if [ -n "${SSH_CONNECTION}" ]
then
  export BROWSER="w3m"
  export OPENER="w3m"
else
  if [ "${OS}" = "linux" ]
  then
    export BROWSER="/usr/local/bin/browser"
    export OPENER="xdg-open"
  elif [ "${OS}" = "darwin" ]
  then
    export BROWSER="open"
    export OPENER="open"
  fi
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Programs & tools                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export SSH_KEY_PATH="${HOME}/.ssh/id_ed25519"

# Pass 
export PASSWORD_STORE_DIR="${HOME}/cloud/library/pass"

# Enable Erlang/IEx shell history
export ERL_AFLAGS="-kernel shell_history enabled"

# IPFS
export IPFS_PATH="${HOME}/.ipfs"

# Firefox
#export GDK_BACKEND="wayland"
export MOZ_ENABLE_WAYLAND="1"
export MOZ_USE_XINPUT2="1"

# Qt
#export QT_STYLE_OVERRIDE="kvantum"
export QT_QPA_PLATFORM="wayland-egl"
export QT_QPA_PLATFORMTHEME="qt5ct"

# https://github.com/oz/tz/
export TZ_LIST="\
Pacific/Honolulu;America/Los_Angeles;\
America/Panama;America/New_York;\
Etc/UTC;Europe/Berlin;\
Asia/Bangkok;Asia/Tokyo;\
Australia/Melbourne;Pacific/Auckland;"

# https://notmuchmail.org/manpages/notmuch-1/
export NOTMUCH_PROFILE="01"

# https://github.com/mrusme/zeit
export ZEIT_DB="${HOME}/cloud/library/tools/zeit.db"

# https://github.com/mrusme/addrb
export ADDRB_DB="${HOME}/.cache/addrb.db"
export ADDRB_TEMPLATE="${HOME}/.config/addrb.tmpl"

# https://github.com/mrusme/caldr
export CALDR_DB="${HOME}/.cache/caldr.db"
export CALDR_TEMPLATE="${HOME}/.config/caldr.tmpl"

# Import color scheme via wal
#__is_available wal linux \ 
#&& (wal -r &)

# https://github.com/Cloudef/bemenu
export BEMENU_OPTS="-n -c -s -i \
  -W 0.3 -H 26 -B 2 -l 10 \
  -p '▲' -P '' --ch 16 --scrollbar always \
  --fn 'CommitMono Nerd Font 11' \
  --nb #040606cc --nf #ABB2BF \
  --ab #040606cc --af #ABB2BF \
  --hb #ABB2BFff --hf #040606 \
  --sb #ABB2BFff --sf #040606 \
  --fb #040606cc --ff #ABB2BF \
  --fbb #040606cc --fbf #ABB2BF \
  --tb #040606cc --tf #ABB2BF \
  --scb #040606cc --scf #ABB2BF66 \
  --bdr #ABB2BF"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ ${PATH}                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# LD_LIBRARY_PATH
if [ "${OS}" = "linux" ]
then
  export LD_LIBRARY_PATH="/usr/local/lib64:$LD_LIBRARY_PATH"
fi

# MacOS
if [ "${OS}" = "darwin" ]
then
  eval "$(/usr/libexec/path_helper -s)"
  # /usr/local/* (Homebrew, etc)
  export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/opt/binutils/bin:${PATH}"
  export MANPATH="/usr/local/man:${MANPATH}"

  # Go
  export GOROOT="/usr/local/opt/go/libexec"

  # Ruby
  export PATH="/usr/local/Cellar/ruby/$(ls -1 /usr/local/Cellar/ruby/ \
                                      | sort \
                                      | tail -n 1)/bin:${PATH}"
fi

# Cargo (Rust)
[ -d "${HOME}/.cargo/bin" ] \
&& export PATH="${HOME}/.cargo/bin:${PATH}"

[ -e "${HOME}/.cargo/env" ] \
&& source "${HOME}/.cargo/env"

# Go
go env -w GOPATH="${HOME}/.go"
export PATH="$(go env GOPATH)/bin:${PATH}"
export GOPROXY="direct"
export GOTOOLCHAIN=local+auto

# Python virtualenv
export VIRTUALENVWRAPPER_PYTHON="$(which python3)"
export WORKON_HOME="${HOME}/.virtualenvs"
function activate.virtualenv {
  __is_available virtualenvwrapper_lazy.sh \
  && source "$(which virtualenvwrapper_lazy.sh)" \
  && workon | grep local > /dev/null \
  && workon local \
  && printf "Activated local.\n" \
  || printf "Could not load virtualenvwrapper.\n"
}

export PYTHON_MAJOR_MINOR="$(python3 \
  --version | sed -nr 's/.*([0-9]+\.[0-9]+)\..*/\1/p')"

[ -d "${HOME}/Library/Python/${PYTHON_MAJOR_MINOR}/bin" ] \
&& export PATH="${HOME}/Library/Python/${PYTHON_MAJOR_MINOR}/bin:${PATH}"

# Rubygems
__is_available gem \
&& export PATH="${HOME}/.gem/bin:${PATH}" \
&& export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:${PATH}"

# NPM
export NPM_PACKAGES="${HOME}/.local/lib64/node_modules"
export PATH="${PATH}:${NPM_PACKAGES}/bin:${HOME}/.local/bin"
export MANPATH="${MANPATH-$(manpath)}:${NPM_PACKAGES}/share/man"

# Wayland
if __is_available sway linux
then
  alias sway-launch="dbus-launch --exit-with-session sway"
  if test -z "${XDG_RUNTIME_DIR}"
  then
    export XDG_RUNTIME_DIR="/tmp/${UID}-runtime-dir"
    if ! test -d "${XDG_RUNTIME_DIR}"
    then
      mkdir "${XDG_RUNTIME_DIR}"
      chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
  fi
  # GTK_THEME="$(gsettings get org.gnome.desktop.interface gtk-theme)"
  GTK_THEME="Windows-95"
  export GTK2_RC_FILES="${HOME}/.themes/${GTK_THEME}/gtk-2.0/gtkrc"
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ OMZ                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export ZSH="${HOME}/.oh-my-zsh"
# [ -e ${ZSH} ] || \
# ([ "${USER}" != "root" ] && sh -c "$(curl -fsSL \
#     https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)")


__is_available starship \
|| ZSH_THEME="geometry-zsh/geometry"

[ "${USER}" = "root" ] \
&& GEOMETRY_SEPARATOR=" root"

CASE_SENSITIVE="true"

zstyle ':omz:update' mode auto
[ "${USER}" = "root" ] \
&& zstyle ':omz:update' mode disabled
zstyle ':omz:update' frequency 10
zstyle ':omz:update' verbose minimal

DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="false"
DISABLE_UNTRACKED_FILES_DIRTY="false"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGESTIONS="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}\
/plugins/zsh-autosuggestions"
ZSH_COMPDUMP="${XDG_CACHE_HOME}/.zcompdump-${HOST}"

zstyle ':omz:*' aliases no
zstyle ':omz:lib:*' aliases no
zstyle ':omz:lib:directories' aliases no
zstyle ':omz:plugins:*' aliases no

# === PLUGINS ===
plugins=(history zsh-autosuggestions fzf aliases)

if [ "${USER}" != "root" ]
then 
  plugins+=( \
    gpg-agent ssh-agent \
    genpass git git-extras golang rust gh vi-mode \
    rsync mosh pass \
    encode64 extract urltools isodate \
  )
fi

if [ "${OS}" = "darwin" ]
then 
  plugins+=(brew tmux macos)
fi
# ===         ===

[ -e "${ZSH}/oh-my-zsh.sh" ] \
&& source "${ZSH}/oh-my-zsh.sh"

fpath=(
  /usr/local/share/zsh-completions
  /usr/local/share/zsh/site-functions
  ${fpath}
)

ZSH_THEME_TERM_TITLE_IDLE='zsh %n@%m:%~'


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Bindkeys                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

bindkey '^f' forward-char
bindkey '^[f' forward-word 
bindkey '^H' backward-kill-word

[ "${OS}" = "darwin" ] \
&& bindkey "\e[1;3C" forward-word \
&& bindkey "\e[1;3D" backward-word


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Aliases                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# https://github.com/zsh-users/zsh/blob/master/Functions/Misc/zmv
alias zmv='noglob zmv -vW'

# https://github.com/ajeetdsouza/zoxide
__is_available zoxide \
&& [ "${USER}" != "root" ] \
&& eval "$(zoxide init --cmd cd zsh)"

# https://github.com/sharkdp/bat
__is_available bat \
&& alias cat=bat

# https://github.com/eza-community/eza
__is_available eza \
&& alias ls='eza --time-style=long-iso --git --binary -lg' \
&& alias la='eza --time-style=long-iso --git --icons --binary -la' \
&& alias ll='eza --time-style=long-iso --git --icons --octal-permissions --binary --changed -lahHgnuU' \
&& alias l='eza --time-style=long-iso --git --icons --binary -l --no-time' \
&& alias lls='eza -las modified'

# https://github.com/ClementTsang/bottom
__is_available btm \
&& alias top='btm'

# https://github.com/neomutt/neomutt
__is_available neomutt \
&& alias mutt=neomutt

# https://github.com/neovim/neovim
__is_available nvim \
&& alias vi=nvim \
&& alias vim=nvim

# https://github.com/junegunn/fzf
__is_available fzf \
&& alias preview='fzf --preview="bat {} --color=always"'

# https://github.com/nerdypepper/eva
__is_available eva \
&& alias calc='eva'

# https://github.com/TomNomNom/gron
__is_available gron \
&& alias json='gron'

# https://github.com/sharkdp/hexyl
__is_available hexyl \
&& alias hex='hexyl'

# https://github.com/sharkdp/hyperfine
__is_available hyperfine \
&& alias benchmark='hyperfine'

# https://github.com/irssi/irssi
__is_available irssi \
&& alias irc='irssi'

# https://github.com/kdheepak/taskwarrior-tui
__is_available taskwarrior-tui \
&& alias todo='taskwarrior-tui'

__is_available xdg-open linux \
&& alias open='xdg-open'

__is_available doas linux \
&& alias fucking='doas' \
|| alias fucking='sudo'

alias uuid=uuidgen
alias wget='wget --no-hsts'
alias rmrf='rm -rf'

alias tgz='tar -czf'
alias ugz='tar -xzf'
alias tbz='tar -cjf'
alias ubz='tar -xjf'

alias tailall='tail -f $(find /var/log -type f | grep -v '.gz$')'

alias my-ip="curl http://ipecho.net/plain; echo"

# Journal (https://xn--gckvb8fzb.com)
export JRNL="${HOME}/projects/@mrusme/xn--gckvb8fzb.com/content"
alias jrnl="cd ${JRNL}"
alias bookmarks="git -C ${JRNL} checkout develop \
  && vim ${JRNL}/bookmarks/index.md \
  && git -C ${JRNL} add bookmarks \
  && git -C ${JRNL} commit -S"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║    __ __    __                                                             ║
# ║   / // /__ / /__  ___ _______                                              ║
# ║  / _  / -_) / _ \/ -_) __(_-<                                              ║
# ║ /_//_/\__/_/ .__/\__/_/ /___/                                              ║
# ║           /_/                                                              ║
# ╚════════════════════════════════════════════════════════════════════════════╝


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Mosh/SSH wrapper                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function ssh {
  if [ "$2" = "" ]
  then
    conn="$1"
    sshhost=$(printf "%s" "${conn}" | cut -d '@' -f2)
    if rg -U -i "^#.*Features:.*mosh.*\nHost ${sshhost}" "${HOME}/.ssh/config" > /dev/null
    then
      printf "connecting with mosh ...\n"
      command mosh ${conn}
    else
      printf "connecting with ssh ...\n"
      command ssh ${conn}
    fi
  else
    printf "connecting with ssh ...\n"
    command ssh $@
  fi
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Poor-man's aptitude                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if ! __is_available aptitude linux true
then
  _aptitude()
  {
    local cur 
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W \
      'install remove purge update upgrade safe-upgrade full-upgrade \
       search show clean reinstall' -- "${cur}") )
    return 0
  }
  complete -F "_aptitude" "aptitude"
  alias apt='aptitude'
fi

if [ "${OS}" = "darwin" ]
then
  function aptitude {
    if [ -z "$1" ]; then
      printf "Usage: aptitude <action> [options] ...\n"
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
        *)           printf "aptitude: '%s' - unknown action\n" "$1" ;;
      esac
    fi
  }
elif __is_available emerge linux true
then
  function aptitude {
    if [ -z "$1" ]; then
      printf "Usage: aptitude <action> [options] ...\n"
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
        *)           printf "aptitude: '%s' - unknown action\n" "$1" ;;
      esac
    fi
  }
elif __is_available pacman linux true
then
  function aptitude {
    if [ -z "$1" ]; then
      printf "Usage: aptitude <action> [options] ...\n"
    else
      case $1 in
        install)     pacman -S "${@:2}";;
        remove)      pacman -R "${@:2}";;
        purge)       pacman -Rs "${@:2}";;
        update)      pacman -Syy "${@:2}";;
        upgrade)     pacman -Syu "${@:2}";;
        safe-upgrade)pacman -Syu "${@:2}";;
        full-upgrade)pacman -Syu "${@:2}";;
        search)      pacman -Ss "${@:2}";;
        show)        pacman -Si "${@:2}";;
        clean)       pacman -Scc "${@:2}";;
        reinstall)   pacman -S "${@:2}";;
        *)           printf "aptitude: '%s' - unknown action\n" "$1" ;;
      esac
    fi
  }
elif __is_available pkg_add openbsd
then
  function aptitude {
    if [ -z "$1" ]; then
      printf "Usage: aptitude <action> [options] ...\n"
    else
      case $1 in
        install)     pkg_add "${@:2}";;
        remove)      pkg_delete "${@:2}";;
        purge)       pkg_delete -a "${@:2}";;
        update)      pkg_add -Uuin "${@:2}";;
        upgrade)     pkg_add -Uui "${@:2}";;
        safe-upgrade)sysupgrade;;
        full-upgrade)sysupgrade;;
        search)      pkg_info -Q "${@:2}";;
        show)        pkg_info "${@:2}";;
        clean)       pkg_check "${@:2}";;
        reinstall)   pkg_add -Uui "${@:2}";;
        *)           printf "aptitude: '%s' - unknown action\n" "$1" ;;
      esac
    fi
  }
fi

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Gentoo packages helper                                                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if __is_available equery
then
  function __packages_list() {
    case "$1" in 
      nongentoo)
        eselect --brief repository list -i \
        | awk '{ print $1 }' \
        | while read -r repo; \
          do 
            [ "$repo" != "gentoo" ]  && equery has repository "$repo"; \
          done
        ;;
      9999)
        equery list '*' | rg '\-9999'
        ;;
      *) 
        printf "unknown: %s\n" "$1"
        ;;
    esac 
  }

  function packages() {
    case "$1" in
      list) __packages_list "${@:2}";;
    esac
  }
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ update-tools                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function update-tools() {
  printf "Updating Rust tools ...\n"
  cargo install-update -a -g

  printf "\nUpdating Go tools ...\n"
  /bin/ls -1 ~/.go/bin/ \
    | while read -r bin; do go version -m "${HOME}/.go/bin/${bin}" \
    | grep '^[[:space:]]path' \
    | awk '{ print $2 }' \
    | grep '^github.com' \
    | sort \
    | uniq \
    | xargs -I{} go install {}@latest; done

  printf "\nUpdating NPM tools ...\n"
  npm update -g

  printf "\nUpdating gh extensions ...\n"
  gh extension upgrade --all

  printf "\nUpdating vale ...\n"
  vale sync

  printf "\nUpdating tealdeer ...\n"
  tldr --update

  printf "\nUpdating Zsh plugins ...\n"
  git -C ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull
  git -C ~/.oh-my-zsh/themes/geometry-zsh pull

  printf "\nTools updated"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Radicle                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

autoload -U zmv add-zsh-hook

__rad_checker() {
  emulate -L zsh
  if [ -d .git/refs/remotes/rad/ ]
  then 
    rad auth 
  fi
}
add-zsh-hook chpwd __rad_checker


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Git                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

alias ga='git add'
alias ga.='ga .'
alias gb='git branch'

alias gc='git commit --verbose'
alias 'gc!'='git commit --verbose --amend'
alias gcs='git commit --gpg-sign'
alias 'gcs!'='git commit --verbose --gpg-sign --amend'
alias gcss='git commit --gpg-sign --signoff'
alias 'gcss!'='git commit --verbose --gpg-sign --signoff --amend'

alias gcb='git checkout -b'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'

alias gcl='git clone --recurse-submodules'

alias gd='git diff'
alias gds='git diff --staged'

alias gf='git fetch'
alias gfa='git fetch --all --prune --jobs=10'

alias gl='git pull'

alias gp='git remote \
  | xargs -I R git push R "$(git_current_branch)"'
alias gpa='git remote \
  | xargs -I R git push R --all'
alias gpat='git remote \
  | xargs -I R git push R --all && git remote \
  | xargs -I R git push R --tags'
alias 'gpfat!'='git remote \
  | xargs -I R git push R --all --force && git remote \
  | xargs -I R git push R --tags --force'
alias 'gpf!'='git remote \
  | xargs -I R git push R --all --force'
alias gpoat='echo "Deprecated, use gpat"'
alias 'gpoat!'='echo "Deprecated, use gpfat!"'

alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'

alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'

alias gsb='git status --short --branch'

alias gts='git tag --sign'

# git tag delete
gtd() {
  git tag -d "$1"
  git remote | while read -r remote; do git push --delete "${remote}" "$1"; done
}

alias git-crypt-add-myself="git-crypt add-gpg-user \
4D3899AF73E7F5FE9B39C822272ED814BF63261F"

function git-find-modified-repos() {
  find ./ -type d -name '.git' | while read -r dir
  do 
    repo=$(dirname "${dir}")
    repostatus=$(git -C "${repo}" status -s)
    if [ -n "${repostatus}" ]
    then 
      printf "%s\n" "${repo}"
    fi 
  done
}

# github checkout issue
function ghcoi() {
  if [ "$1" = "" ]
  then
    printf "usage: %s <issue number>\n" "$0"
    exit 1
  fi

  git checkout -b "$1-$(gh issue view "$1" --json title \
    | jq --raw-output '.title' \
    | iconv -t ascii//TRANSLIT \
    | sed -E 's/[^a-zA-Z0-9]+/-/g' \
    | sed -E 's/^-+|-+$//g' \
    | tr '[:upper:]' '[:lower:]')"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ What's ...                                                                 ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function whats() {
  if ! __is_available units || ! __is_available whatis
  then 
    printf "This command requires units(1) and whatis(1)!\n"
    return 1 
  fi 

  value=""
  value_unit=""
  from_unit=""
  to=""
  to_unit=""
  _in=""
  _in_unit=""

  if [ "$#" -eq "1" ]
  then
    if [ "$1" = "love" ]
    then 
      printf "... got to do, got to do with it?\n"
      return 0 
    else 
      whatis "$1"
      return "$?"
    fi 
  elif [ "$#" -eq "2" ]
  then
    value_unit="$1"
    to_unit="$2"
  elif [ "$#" -eq "3" ]
  then
    if [ "$2" = "to" ] || [ "$2" = "in" ] || [ "$2" = "of" ]
    then 
      value_unit="$1"
      to="$2"
      to_unit="$3"
    else 
      value="$1"
      from_unit="$2"
      to_unit="$3"
    fi
  elif [ "$#" -eq "4" ]
  then 
    value="$1"
    from_unit="$2"
    to="$3"
    to_unit="$4"
  elif [ "$#" -eq "5" ]
  then
    value="$1"
    from_unit=""
    to="$2"
    to_unit="$3"
    _in="$4"
    _in_unit="$5"
  else
    printf "usage: %s <value>[[ ]unit] [to/in|of] <to/in unit/value|of value> [in %%]\n" "$0"
    printf "\n"
    printf "examples:\n"
    printf "\n"
    printf "  %s 20 kmh in mph\n" "$0"
    printf "  %s 3 cups in ml\n" "$0"
    printf "  %s 6ft to m\n" "$0"
    printf "  %s 10%% of 120\n" "$0"
    printf "  %s 10 of 200 in %%\n" "$0"
    printf "  %s 10 to 100 in %%\n" "$0"
    printf "\n"
    return 1 
  fi

  if [ "${value_unit}" != "" ]
  then
    combined="$(printf "%s" "${value_unit}" | grep -Eo '[[:alpha:]\$\%]+|[0-9]+')"
    value="$(printf "%s" "${combined}" | head -n 1)"
    from_unit="$(printf "%s" "${combined}" | tail -n 1)"
  fi

  from_unit=$(printf "%s" "${from_unit}" | tr '[:upper:]' '[:lower:]')
  to_unit=$(printf "%s" "${to_unit}" | tr '[:upper:]' '[:lower:]')

  units_from="${value}${from_unit}"
  units_to="${to_unit}"

  case "${from_unit}" in 
    "f")
      units_from="tempF(${value})"
      ;;
    "c")
      units_from="tempC(${value})"
      ;;
    "kmh")
      units_from="${value} km/hour"
      ;;
  esac 

  case "${to_unit}" in 
    "f")
      units_to="tempF"
      ;;
    "c")
      units_to="tempC"
      ;;
    "kmh")
      units_to="km/hour"
      ;;
  esac
  
  if [ "${from_unit}" = "%" ]
  then 
    eva "(${value} / 100) * ${units_to}" | tr -d ' '
    return "$?"
  elif [ "${_in}" != "" ] && [ "${_in_unit}" = "%" ]
  then 
    if [ "${to}" = "of" ]
    then
      eva "(${value} / ${to_unit}) * 100" | tr -d ' '
      return "$?"
    elif [ "${to}" = "to" ]
    then 
      eva "((${to_unit} - ${value}) / ${value}) * 100" | tr -d ' '
      return "$?"
    fi
  else
    units --compact -1 "${units_from}" "${units_to}"
    return "$?"
  fi
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Online tools                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function jitsi-link() {
  url=$(printf "https://meet.jit.si/%s" "$(uuidgen)")
  printf "%s" "${url}" | wl-copy
  printf "%s\n" "${url}"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Multimedia                                                                 ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function video-to-gif() {
  fps="$3"
  if [[ "$3" == "" ]];
  then 
    fps="10"
  fi

  ffmpeg \
    -i "$1" \
    -filter_complex \
    "[0:v]setpts=0.25*PTS,fps=$fps,scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -filter:a 'atempo=2,atempo=2' \
    -loop 0 \
    "$2"
}

function rip() {
  yt-dlp \
    -f bestaudio \
    --extract-audio \
    --audio-format mp3 \
    --audio-quality 0 \
    --yes-playlist \
    --add-metadata \
    "$1"
}

function listen() {
  url="$1"
  if [ "$1" = "to" ]
  then 
    url="$2"
  fi 

  mpv \
    --quiet \
    --no-video \
    "$url"
}

function compress-all-jpgs() {
  find ./ \
    -iname '*.jpg' \
    -type f \
    -size +2M \
    -exec imager -f jpeg -i "{}" -o "{}" \;
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ addrb (https://github.com/mrusme/addrb)                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function addrb() {
  match=$(echo "$*" | grep -o '\-r')
  if [ "$match" != "" ]
  then 
    export CARDDAV_USERNAME="$(pass show dav/username)"
    export CARDDAV_PASSWORD="$(pass show dav/password)"
    export CARDDAV_ENDPOINT="$(pass show dav/endpoint)"
  fi
  
  command addrb $@
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ caldr (https://github.com/mrusme/caldr)                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function caldr() {
  match=$(echo "$*" | grep -o '\-r')
  if [ "$match" != "" ]
  then 
    export CARDDAV_USERNAME="$(pass show dav/username)"
    export CARDDAV_PASSWORD="$(pass show dav/password)"
    export CARDDAV_ENDPOINT="$(pass show dav/endpoint)"
  fi
  
  command caldr $@
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ planor (https://github.com/mrusme/planor)                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function planor() {
  export VULTR_API_KEY="$(pass show vultr/token)"
  export RENDER_API_TOKEN="$(pass show render/token)"
  export FLEEK_API_TOKEN="$(pass show fleek/token)"
  export FLEEK_TEAM_ID="$(pass show fleek/team)"
  
  command planor $@
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ conclusive (https://github.com/mrusme/conclusive)                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function conclusive() {
  export PLAUSIBLE_TOKEN="$(pass show plausible/token)"
  
  command conclusive $@
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ wtfutil                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function wtfutil() {
  export WTF_GITHUB_TOKEN="$(pass show wtfutil/token)"
  
  command wtfutil $@
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ gh                                                                         ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function gh() {
  export GITHUB_TOKEN="$(pass show github/token)"
  
  command gh $@
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ mods                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function mods() {
  export OPENAI_API_KEY="$(pass show openai/apikey)"
  
  command mods $@
}

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Fabric                                                                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

[ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ] \
&& . "$HOME/.config/fabric/fabric-bootstrap.inc"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Dotfiles management                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export DOTFILES="${HOME}/projects/@mrusme/dotfiles"

function dotfiles-update-remote() {
  cp "${HOME}/.zshrc" "${DOTFILES}/.zshrc"
  cp "${HOME}/.tmux.conf" "${DOTFILES}/.tmux.conf"
  cp "${HOME}/.tmux.cheatsheet" "${DOTFILES}/.tmux.cheatsheet"
  cp "${HOME}/.motd" "${DOTFILES}/.motd"
  cp "${HOME}/.mbsyncrc" "${DOTFILES}/.mbsyncrc"
  cp "${HOME}/.vale.ini" "${DOTFILES}/.vale.ini"
  cp "${HOME}/.wallpaper" "${DOTFILES}/.wallpaper"

  mkdir -p "${DOTFILES}/.ssh/"
  rsync -avH "${HOME}/.ssh/config" "${DOTFILES}/.ssh/config"

  rsync -avH \
    --exclude-from="${DOTFILES}/.exclude" \
    "${HOME}/.irssi/" "${DOTFILES}/.irssi/"

  rsync -avH \
    --exclude-from="${DOTFILES}/.exclude" \
    "${XDG_CONFIG_HOME}/" "${DOTFILES}/.config/" --delete-before

  if [ "${OS}" = "darwin" ]
  then
    brew ls --formula -1 --full-name > "${DOTFILES}/brew_ls_-1"
    brew ls --cask -1 --full-name > "${DOTFILES}/brew_cask_ls_-1"
  fi
  if [ "${OS}" = "linux" ]
  then
    mkdir -p "${DOTFILES}/usr/local/bin/"
    /usr/bin/find /usr/local/bin -type f -exec sh -c '
      case $( file -bi "$1" ) in (*/x-shellscript*) exit 0; esac
      exit 1' sh {} \; -print | while read -r scriptfile
      do
        rsync -avH "${scriptfile}" "${DOTFILES}/usr/local/bin/"
      done

    mkdir -p "${DOTFILES}/.local/share/applications/"
    rsync -avH \
      "${HOME}/.local/share/applications/browser.desktop" \
      "${DOTFILES}/.local/share/applications/browser.desktop"
  fi

  cargo install --list > "${DOTFILES}/cargo_install_--list"

  npm list -g --depth=0 > "${DOTFILES}/npm_list_-g_--depth_0"

  /bin/ls -1 ~/.go/bin/ \
    | while read -r bin; \
    do go version -m "${HOME}/.go/bin/${bin}" \
    | grep '^[[:space:]]path' \
    | awk '{ print $2 }' \
    | grep '^github.com' \
    | sort \
    | uniq;\
    done > "${DOTFILES}/go_list_github-com"

  gh extension list > "${DOTFILES}/gh_extension_list"

  git -C "${DOTFILES}" commit -a -S
  return 0
}

function dotfiles-update-local() {
  printf "are you sure? (y/n) "
  read -r confirmation

  [ "${confirmation}" != "y" ] && return 1

  cp "${DOTFILES}/.zshrc" "${HOME}/.zshrc"
  cp "${DOTFILES}/.tmux.conf" "${HOME}/.tmux.conf"
  cp "${DOTFILES}/.tmux.cheatsheet" "${HOME}/.tmux.cheatsheet"
  cp "${DOTFILES}/.motd" "${HOME}/.motd"
  cp "${DOTFILES}/.mbsyncrc" "${HOME}/.mbsyncrc"
  cp "${DOTFILES}/.vale.ini" "${HOME}/.vale.ini"
  cp "${DOTFILES}/.wallpaper" "${HOME}/.wallpaper"

  rsync -avH "${DOTFILES}/ssh/config" "${HOME}/.ssh/config"

  rsync -avH \
    --exclude-from="${DOTFILES}/.exclude" \
    "${DOTFILES}/irssi/" "${HOME}/.irssi/"

  rsync -avH \
    --exclude-from="${DOTFILES}/.exclude" \
    "${DOTFILES}/.config/" "${XDG_CONFIG_HOME}/" 

  if [ "${OS}" = "linux" ]
  then
    cp "${DOTFILES}/usr/local/bin/"* /usr/local/bin/

    mkdir -p "${HOME}/.local/share/applications/" 
    cp "${DOTFILES}/local/share/applications/browser.desktop" \
      "${HOME}/.local/share/applications/browser.desktop"
  fi
  return 0
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ motd                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

DOT_MOTD="${HOME}/.motd"
[ -e "${DOT_MOTD}" ] \
&& source "${DOT_MOTD}"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Stoicism                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

fortune stoic
printf "\n"


__is_available starship \
&& eval "$(starship init zsh)"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Stuff other programs dare to append goes here                              ║
# ╚════════════════════════════════════════════════════════════════════════════╝
#
# ...

# zprof
