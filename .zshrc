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

export ICONS_PATH="${HOME}/cloud/library/icons/winicons"

# if [ "$(lspci | grep -i geforce)" ]
# then
#   export WLR_NO_HARDWARE_CURSORS=1
# fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Ghostty                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
  builtin source \
    "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
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

export HISTFILE="${HOME}/.zsh_history"
export HISTCONTROL="ignoredups:ignorespace"
export HISTSIZE="100000"
export HISTFILESIZE="200000"
export SAVEHIST="${HISTSIZE}"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS 
setopt HIST_VERIFY
setopt SHARE_HISTORY

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
  #export GTK_ICON_THEME_NAME="Chicago95"
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Completions                                                                ║
# ╚════════════════════════════════════════════════════════════════════════════╝

autoload -U compaudit compinit zrecompile

if [[ -z "$ZSH_COMPDUMP" ]]; then
  ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi 

compinit -i -d "$ZSH_COMPDUMP"

if command mkdir "${ZSH_COMPDUMP}.lock" 2>/dev/null; then
  zrecompile -q -p "$ZSH_COMPDUMP"
  command rm -rf "$ZSH_COMPDUMP.zwc.old" "${ZSH_COMPDUMP}.lock"
fi

zmodload -i zsh/complist
WORDCHARS=''

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list \
  'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors \
  '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01' 
zstyle ':completion:*:*:*:*:processes' command \
  "ps -u $USERNAME -o pid,user,comm -w -w" 
zstyle ':completion:*:cd:*' tag-order \
  local-directories directory-stack path-directories
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
  clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
  gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
  ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
  named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
  operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
  usbmux uucp vcsa wwwrun xfs '_*'
zstyle '*' single-ignored show 

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Autosuggestions                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGESTIONS="${HOME}/.zsh/zsh-autosuggestions"
ZSH_COMPDUMP="${XDG_CACHE_HOME}/.zcompdump-${HOST}"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Misc                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

autoload -Uz is-at-least
setopt multios              # enable redir to multi streams: echo >file1 >file2
setopt long_list_jobs       # show long list format job notifications
setopt interactivecomments  # recognize comments


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ GPG                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export GPG_TTY=$TTY

# Fix for passphrase prompt on the correct tty
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html#option-_002d_002denable_002dssh_002dsupport
function _gpg-agent_update-tty_preexec {
  gpg-connect-agent updatestartuptty /bye &>/dev/null
}
autoload -U add-zsh-hook
add-zsh-hook preexec _gpg-agent_update-tty_preexec

# If enable-ssh-support is set, fix ssh agent integration
if [[ $(gpgconf --list-options gpg-agent 2>/dev/null \
        | awk -F: '$1=="enable-ssh-support" {print $10}') = 1 ]]; then
  unset SSH_AGENT_PID
  if [[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  fi
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ SSH                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

ssh_env_cache="$HOME/.ssh/environment-$SHORT_HOST"

function _start_agent() {
  # Check if ssh-agent is already running
  if [[ -f "$ssh_env_cache" ]]; then
    . "$ssh_env_cache" > /dev/null

    # Test if $SSH_AUTH_SOCK is visible
    zmodload zsh/net/socket
    if [[ -S "$SSH_AUTH_SOCK" ]] \
    && zsocket "$SSH_AUTH_SOCK" 2>/dev/null; then
      return 0
    fi
  fi

  if [[ ! -d "$HOME/.ssh" ]]; then
    echo "ssh-agent plugin requires ~/.ssh directory"
    return 1
  fi

  # Set a maximum lifetime for identities added to ssh-agent
  local lifetime

  # start ssh-agent and setup environment
  echo >&2 "Starting ssh-agent ..."
  ssh-agent -s ${lifetime:+-t} ${lifetime} \
    | sed '/^echo/d' >! "$ssh_env_cache"
  chmod 600 "$ssh_env_cache"
  . "$ssh_env_cache" > /dev/null
}

function _add_identities() {
  local id file line sig lines
  local -a identities loaded_sigs loaded_ids not_loaded

  # check for .ssh folder presence
  if [[ ! -d "$HOME/.ssh" ]]; then
    return
  fi

  # add default keys if no identities were set up via zstyle
  # this is to mimic the call to ssh-add with no identities
  if [[ ${#identities} -eq 0 ]]; then
    # key list found on `ssh-add` man page's DESCRIPTION section
    for id in id_rsa id_dsa id_ecdsa id_ed25519 id_ed25519_sk identity; do
      # check if file exists
      [[ -f "$HOME/.ssh/$id" ]] && identities+=($id)
    done
  fi

  # get list of loaded identities' signatures and filenames
  if lines=$(ssh-add -l); then
    for line in ${(f)lines}; do
      loaded_sigs+=${${(z)line}[2]}
      loaded_ids+=${${(z)line}[3]}
    done
  fi

  # add identities if not already loaded
  for id in $identities; do
    # if id is an absolute path, make file equal to id
    [[ "$id" = /* ]] && file="$id" || file="$HOME/.ssh/$id"
    # check for filename match, otherwise try for signature match
    if [[ -f $file && ${loaded_ids[(I)$file]} -le 0 ]]; then
      sig="$(ssh-keygen -lf "$file" | awk '{print $2}')"
      [[ ${loaded_sigs[(I)$sig]} -le 0 ]] && not_loaded+=("$file")
    fi
  done

  # abort if no identities need to be loaded
  if [[ ${#not_loaded} -eq 0 ]]; then
    return
  fi

  local args

  ssh-add "${args[@]}" ${^not_loaded}
}

# Add a nifty symlink for screen/tmux if agent forwarding is enabled
if [[ -n "$SSH_AUTH_SOCK" ]]; then
  if [[ ! -L "$SSH_AUTH_SOCK" ]]; then
    if [[ -n "$TERMUX_VERSION" ]]; then
      ln -sf "$SSH_AUTH_SOCK" "$PREFIX"/tmp/ssh-agent-$USERNAME-screen
    else
      ln -sf "$SSH_AUTH_SOCK" /tmp/ssh-agent-$USERNAME-screen
    fi
  fi
else
  _start_agent
fi

_add_identities

unset agent_forwarding ssh_env_cache
unfunction _start_agent _add_identities


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ FZF                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function fzf_setup_using_fzf() {
  (( ${+commands[fzf]} )) || return 1

  local fzf_ver=${"$(fzf --version)"#fzf }

  autoload -Uz is-at-least
  is-at-least 0.48.0 ${${(s: :)fzf_ver}[1]} || return 1

  eval "$(fzf --zsh)"
}

function fzf_setup_error() {
  cat >&2 <<'EOF'
fzf plugin: Cannot find fzf installation directory.
Please add `export FZF_BASE=/path/to/fzf/install/dir` to your .zshrc
EOF
}

fzf_setup_using_fzf \
  || fzf_setup_error

unset -f -m 'fzf_setup_*'

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Bindkeys                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Use emacs key bindings
bindkey -e

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M emacs "${terminfo[khome]}" beginning-of-line
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M emacs "${terminfo[kend]}"  end-of-line
  bindkey -M viins "${terminfo[kend]}"  end-of-line
  bindkey -M vicmd "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M emacs "${terminfo[kdch1]}" delete-char
  bindkey -M viins "${terminfo[kdch1]}" delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char

  bindkey -M emacs "^[3;5~" delete-char
  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word


bindkey '^f' forward-char
bindkey '^[f' forward-word 
bindkey '^H' backward-kill-word

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Launch bemenu
__bemenu() { BEMENU_BACKEND=curses bemenu-run; zle redisplay }
zle -N __bemenu
bindkey '^ ' __bemenu


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Global API keys                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if [[ -o login ]]; then
  export ANTHROPIC_API_KEY="$(pass show anthropic/api-key)"
  export COINGECKO_API_KEY="$(pass show coingecko/api-key)"
  export OPENAI_API_KEY="$(pass show openai/api-key)"
fi


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
  --color=auto --binary -lg' \
&& alias ll='eza  --time-style=long-iso --git --octal-permissions --icons \
  --color=auto --binary -la' \
&& alias la='eza  --time-style=long-iso --git --octal-permissions         \
  --color=auto --binary --changed -lahHgnuU' \
&& alias l='eza   --time-style=long-iso --git                     --icons \
  --color=auto --binary -l --no-time' \
&& alias lls='eza --time-style=long-iso --git --octal-permissions --icons \
  --color=auto --binary -las modified' \
&& alias l1='eza  -1 --icons=never --color=auto'

# https://github.com/aristocratos/btop
__is_available btop \
&& alias top='btop'

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
# ║ age encrypt/decrypt                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

encrypt() {
  if [[ $# -eq 0 ]]; then
    printf "%s: <filename>\n" "$0"
    return 1
  fi
  if [[ "$1" =~ \.age$ ]]; then
    printf "%s: File is already an age file\n" "$0"
    return 1
  fi
  /bin/cat "$1" \
  | age -r $(pass show age/id1) -r $(pass show age/id2) -o "$1.age"
}

decrypt() {
  if [[ $# -eq 0 ]]; then
    printf "%s: <filename>\n" "$0"
    return 1
  fi
  if [[ ! "$1" =~ \.age$ ]]; then
    printf "%s: File is not an age file\n" "$0"
    return 1
  fi
  id1file=$(mktemp)
  id2file=$(mktemp)
  pass show age/id1-identity > "$id1file"
  pass show age/id2-identity > "$id2file"
  /bin/cat "$1" | age -d -i "$id1file" -i "$id2file" > "${1%.age}"
  rm "$id1file" "$id2file"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ encode64/decode64                                                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝

encode64() {
  if [[ $# -eq 0 ]]; then
    cat | base64
  else
    printf '%s' $1 | base64
  fi
}

encodefile64() {
  if [[ $# -eq 0 ]]; then
    echo "You must provide a filename"
  else
    base64 $1 > $1.txt
    echo "${1}'s content encoded in base64 and saved as ${1}.txt"
  fi
}

decode64() {
  if [[ $# -eq 0 ]]; then
    cat | base64 --decode
  else
    printf '%s' $1 | base64 --decode
  fi
}
alias e64=encode64
alias ef64=encodefile64
alias d64=decode64


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Mosh/SSH wrapper                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function ssh {
  if [ "$2" = "" ]
  then
    conn="$1"
    sshhost=$(printf "%s" "${conn}" | cut -d '@' -f2)
    if rg -U -i "^#.*Features:.*mosh.*\nHost ${sshhost}" \
      "${HOME}/.ssh/config" > /dev/null
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
  git -C ~/.zsh/zsh-autosuggestions pull

  printf "\nTools updated"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Git                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

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
    $(printf "%s%s%s%s" \
      "[0:v]setpts=0.5*PTS,fps=" \
      $fps \
      ",scale=800:-1:flags=lanczos,split[s0][s1];" \
      "[s0]palettegen[p];[s1][p]paletteuse") \
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
  awkcommand='{ 
    if($1 < $2) { 
      system("convert " $3 " -resize 2160x " $3); 
      system("convert " $3 " -crop 2160x3840+0+0 " $3) 
    } else { 
      system("convert " $3 " -resize 3840x " $3); 
      system("convert " $3 " -crop 3840x2160+0+0 " $3) 
    }
  }'
  find ./ \
    -type f \
    -iname '*.jpg' \
    -exec identify -format '%w %h %i\n' '{}' \; \
      | awk "$awkcommand"
}

function crop-16-9() {
  awkcommand='{ 
    if($1 < $2) { 
      system("convert " $3 " -crop 2160x3840+0+0 " $3) 
    } else { 
      system("convert " $3 " -crop 3840x2160+0+0 " $3) 
    }
  }'
  find ./ \
    -type f \
    -iname '*.jpg' \
    -exec identify -format '%w %h %i\n' '{}' \; \
      | awk "$awkcommand"
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
  export VULTR_API_KEY="$(pass show vultr/api-key)"
  
  command planor $@
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ gh                                                                         ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function gh() {
  export GITHUB_TOKEN="$(pass show github/token)"
  
  command gh $@
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
