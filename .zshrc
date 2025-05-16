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

unset LS_COLORS
unset LSCOLORS


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Basics                                                                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export OS="$(uname | tr '[:upper:]' '[:lower:]')"

function __is_available {
  prog="${1}"
  os="${2}"

  if [ "${os}" != "" ] && [ "${os}" != "${OS}" ]
  then 
    return 1
  fi

  type "${prog}" > /dev/null 
  return "$?"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Exports                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

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
# ║ Ghostty                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
  builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi


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

export TERM="xterm-256color"
export COLUMNS="80"

# INFO: `nvim` check further down below
export EDITOR="vim"

if [ -n "${SSH_CONNECTION}" ]
then
  export BROWSER="w3m"
  export OPENER="w3m"
else
  export BROWSER="/usr/local/bin/browser"
  export OPENER="xdg-open"
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

# https://github.com/Cloudef/bemenu
export BEMENU_OPTS="-n -c -s -i \
  -W 0.3 -H 26 -B 2 -l 10 \
  -p '▲' -P '' --ch 16 --scrollbar always \
  --fn 'Berkeley Mono 11' \
  --nb #040606cc --nf #FFFFFF \
  --ab #040606cc --af #FFFFFF \
  --hb #72F1B8ff --hf #040606 \
  --sb #72F1B8ff --sf #040606 \
  --fb #040606cc --ff #FFFFFF \
  --fbb #040606cc --fbf #FFFFFF \
  --tb #040606cc --tf #FFFFFF \
  --scb #040606ff --scf #633affff \
  --bdr #72F1B8"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ ${PATH}                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# LD_LIBRARY_PATH
export LD_LIBRARY_PATH="/usr/local/lib64:$LD_LIBRARY_PATH"

# Cargo (Rust)
[ -d "${HOME}/.cargo/bin" ] \
&& export PATH="${HOME}/.cargo/bin:${PATH}"

[ -e "${HOME}/.cargo/env" ] \
&& source "${HOME}/.cargo/env"

# Go
go env -w GOPATH="${HOME}/.go"
export PATH="$(go env GOPATH)/bin:${PATH}"
export GOPROXY="direct"
export GOTOOLCHAIN=local

# Python
#[ -e "${HOME}/.local/share/pyenv/bin/activate" ] \
#&& source "${HOME}/.local/share/pyenv/bin/activate"

# Rubygems
__is_available gem \
&& export PATH="${HOME}/.gem/bin:${PATH}" \
&& export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:${PATH}"

# NPM
export NPM_PACKAGES="${HOME}/.local/lib/node_modules"
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

  # https://github.com/B00merang-Project/Windows-95
  export GTK_THEME="Windows-95"
  export GTK2_RC_FILES="${HOME}/.themes/${GTK_THEME}/gtk-2.0/gtkrc"
  #gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
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

DISABLE_LS_COLORS="true"
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
    genpass git git-extras golang rust gh \
    rsync mosh pass \
    encode64 extract urltools isodate \
  )
fi
# ===         ===

[ -e "${ZSH}/oh-my-zsh.sh" ] \
&& source "${ZSH}/oh-my-zsh.sh"

ZSH_THEME_TERM_TITLE_IDLE='zsh %n@%m:%~'


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Bindkeys                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

bindkey '^f' forward-char
bindkey '^[f' forward-word 
bindkey '^H' backward-kill-word

# Launch bemenu
__bemenu() { BEMENU_BACKEND=curses bemenu-run; zle redisplay }
zle -N __bemenu
bindkey '^ ' __bemenu


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Aliases                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# https://github.com/zsh-users/zsh/blob/master/Functions/Misc/zmv
alias zmv='noglob zmv -vW'

# https://github.com/ajeetdsouza/zoxide
__is_available zoxide \
&& [ "${USER}" != "root" ] \
&& eval "$(zoxide init --cmd cd zsh)" \
&& alias cdd=cdi

# https://github.com/sharkdp/bat
__is_available bat \
&& alias cat=bat

# https://github.com/eza-community/eza
__is_available eza \
&& alias ls='eza  --time-style=relative --git --octal-permissions --icons \
  --binary -lg' \
&& alias ll='eza  --time-style=long-iso --git --octal-permissions --icons \
  --binary -la' \
&& alias la='eza  --time-style=long-iso --git --octal-permissions         \
  --binary --changed -lahHgnuU' \
&& alias l='eza   --time-style=long-iso --git                     --icons \
  --binary -l --no-time' \
&& alias lls='eza --time-style=long-iso --git --octal-permissions --icons \
  --binary -las modified'

# https://github.com/ClementTsang/bottom
__is_available btm \
&& alias top='btm'

# https://github.com/neomutt/neomutt
__is_available neomutt \
&& alias mutt=neomutt

# https://github.com/neovim/neovim
__is_available nvim \
&& alias vi=nvim \
&& alias vim=nvim \
&& export EDITOR="nvim"

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
alias ehco=echo

alias tgz='tar -czf'
alias ugz='tar -xzf'
alias tbz='tar -cjf'
alias ubz='tar -xjf'

alias tailall='tail -f $(find /var/log -type f | grep -v '.gz$')'

alias my-ip="curl http://ipecho.net/plain; echo"

alias element=iamb

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

if ! __is_available aptitude linux
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

if __is_available emerge linux
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
elif __is_available pacman linux
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
  unset GOPROXY
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
alias gcom='git checkout master'
alias gcod='git checkout develop'
alias gcor='git checkout --recurse-submodules'
alias gcorm='git checkout --recurse-submodules master'
alias gcord='git checkout --recurse-submodules develop'

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
alias gtl='git tag -l'

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
    "[0:v]setpts=0.5*PTS,fps=$fps,scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -filter:a 'atempo=1,atempo=1' \
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

function scale-and-crop-16-9() {
  find ./ \
    -type f \
    -iname '*.jpg' \
    -exec identify -format '%w %h %i\n' '{}' \; \
      | awk '{ if($1 < $2) { system("convert " $3 " -resize 2160x " $3); system("convert " $3 " -crop 2160x3840+0+0 " $3) } else { system("convert " $3 " -resize 3840x " $3); system("convert " $3 " -crop 3840x2160+0+0 " $3) }}'
}

function crop-16-9() {
  find ./ \
    -type f \
    -iname '*.jpg' \
    -exec identify -format '%w %h %i\n' '{}' \; \
      | awk '{ if($1 < $2) { system("convert " $3 " -crop 2160x3840+0+0 " $3) } else { system("convert " $3 " -crop 3840x2160+0+0 " $3) }}'
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
# ║ Dotfiles management                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export DOTFILES="${HOME}/projects/@mrusme/dotfiles"

function dotfiles-update-remote() {
  cp "${HOME}/.zshrc" "${DOTFILES}/.zshrc"
  cp "${HOME}/.motd" "${DOTFILES}/.motd"
  cp "${HOME}/.vale.ini" "${DOTFILES}/.vale.ini"
  cp "${HOME}/.wallpaper" "${DOTFILES}/.wallpaper"

  rsync -avH \
    --include-from="${DOTFILES}/.include" \
    "${XDG_CONFIG_HOME}/" "${DOTFILES}/.config/" --delete-before

  mkdir -p "${DOTFILES}/usr/local/bin/"
  rsync -avH \
    --include-from="${DOTFILES}/.include" \
    "/usr/local/" "${DOTFILES}/usr/local/"

  mkdir -p "${DOTFILES}/.local/share/applications/"
  rsync -avH \
    "${HOME}/.local/share/applications/browser.desktop" \
    "${DOTFILES}/.local/share/applications/browser.desktop"

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
  cp "${DOTFILES}/.motd" "${HOME}/.motd"
  cp "${DOTFILES}/.vale.ini" "${HOME}/.vale.ini"
  cp "${DOTFILES}/.wallpaper" "${HOME}/.wallpaper"

  rsync -avH \
    --include-from="${DOTFILES}/.include" \
    "${DOTFILES}/.config/" "${XDG_CONFIG_HOME}/" 

  cp "${DOTFILES}/usr/local/bin/"* /usr/local/bin/

  mkdir -p "${HOME}/.local/share/applications/" 
  cp "${DOTFILES}/local/share/applications/browser.desktop" \
    "${HOME}/.local/share/applications/browser.desktop"
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
