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
# ║      xn--gckvb8fzb.com * codeberg.org/mrus * marius@xn--gckvb8fzb.com      ║
# ║                                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝
# zmodload zsh/zprof

[[ -o interactive ]] || return

unset LS_COLORS
unset LSCOLORS


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Basics                                                                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export OS="${OSTYPE%%-*}"
SHORT_HOST="${HOST%%.*}"

function __is_available {
  local prog="$1" os="${2:-}"
  [[ -z "$os" || "$os" == "$OS" ]] \
  && builtin whence -w -- "$prog" >/dev/null 2>&1
}

function __private_directory() {
  local dir="$1"
  local -A info
  [[ -e "$dir" || -L "$dir" ]] || command mkdir -m 700 -p -- "$dir" || return
  [[ -d "$dir" && ! -L "$dir" && -O "$dir" ]] || return 1
  zmodload -F zsh/stat b:zstat || return
  zstat -H info -- "$dir" || return
  (( (info[mode] & 8#777) == 8#700 ))
}

function __owned_directory() {
  local dir="$1"
  local -A info
  [[ -d "$dir" ]] || command mkdir -p -- "$dir" || return
  [[ -d "$dir" && -O "$dir" ]] || return 1
  zmodload -F zsh/stat b:zstat || return
  zstat -H info -- "$dir" || return
  (( (info[mode] & 8#002) == 0 ))
}

function __replace_file() {
  if [[ -d "$2" ]]; then
    print -u2 -- "Destination is a directory: $2"
    return 1
  fi
  command mv -f -- "$1" "$2"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Exports                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export XCURSOR_THEME="Vimix-White"
export XCURSOR_SIZE="32"

export CLOUD_DIR="${HOME}/cloud"
export PROJECTS_DIR="${HOME}/projects"
export MY_PROJECTS_DIR="${HOME}/projects/@mrus"
export ICONS_PATH="${HOME}/cloud/library/icons/winicons"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DOWNLOAD_DIR="${HOME}/downloads"
export XDG_DESKTOP_DIR="${HOME}/desktop"
export XDG_TEMPLATES_DIR="${HOME}/"
export XDG_PUBLICSHARE_DIR="${HOME}/shared/public"
export XDG_DOCUMENTS_DIR="${CLOUD_DIR}/documents"
export XDG_MUSIC_DIR="${CLOUD_DIR}/music"
export XDG_PICTURES_DIR="${CLOUD_DIR}/photos"
export XDG_VIDEOS_DIR="${CLOUD_DIR}/videos"
# On change adjust `${XDG_CONFIG_HOME}/user-dirs.dirs` as well!

# if [ "$(lspci | grep -i geforce)" ]
# then
#   export WLR_NO_HARDWARE_CURSORS=1
# fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Ghostty                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if [[ -n "$GHOSTTY_RESOURCES_DIR" && -r \
      "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration" ]]
then
  builtin source \
    "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Tmux Magic (via SSH)                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

__is_available tmux \
&& [[ -t 0 && -t 1 ]] \
&& [ -n "${SSH_CONNECTION}" ] \
&& [ -z "${TMUX}" ] \
&& [ "${USER}" != "root" ] \
&& tmux new-session -A -s ssh && exit


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ General config                                                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

HISTFILE="${HOME}/.zsh_history"
HISTSIZE=600000
SAVEHIST=500000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_VERIFY
setopt SHARE_HISTORY

# INFO: `EDITOR` check further down below
export EDITOR="vim"

if [ -n "${SSH_CONNECTION}" ]
then
  export BROWSER="w3m"
  export OPENER="w3m"
else
  export BROWSER="/usr/local/bin/browserselect"
  export OPENER="xdg-open"
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Programs & tools                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# SSH
export SSH_KEY_PATH="${HOME}/.ssh/id_ed25519"
ssh_askpass_bin="$MY_PROJECTS_DIR/ssh-askpass-zigtk/zig-out/bin"
if [[ -x "$ssh_askpass_bin/ssh-askpass-zigtk" ]]; then
  export SSH_ASKPASS="$ssh_askpass_bin/ssh-askpass-zigtk"
  export SSH_ASKPASS_REQUIRE="prefer"
fi
unset ssh_askpass_bin

# Pass 
export PASSWORD_STORE_DIR="${CLOUD_DIR}/library/pass"

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
export QT_QPA_PLATFORMTHEME="qt6ct"

# https://github.com/oz/tz/
export TZ_LIST="\
Pacific/Honolulu;America/Los_Angeles;\
America/Panama;America/New_York;\
Etc/UTC;Europe/Berlin;\
Asia/Bangkok;Asia/Tokyo;\
Australia/Melbourne;Pacific/Auckland;"

# https://tty.fail/mrus/zeit
export ZEIT_DB="${CLOUD_DIR}/library/tools/zeit.db"

# https://tty.fail/mrus/sysdeck
export DMENU_PROGRAM="sysdeck --dmenu"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ ${PATH}                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# LD_LIBRARY_PATH
() {
  local -aU library_paths=(/usr/local/lib64 ${(@s/:/)LD_LIBRARY_PATH})
  library_paths=("${(@)library_paths:#}")
  export LD_LIBRARY_PATH="${(j/:/)library_paths}"
}

typeset -U path PATH
# Ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

# Go
# IMPRTANT: go telemetry off
export GOPATH="${HOME}/.go"
path=("$GOPATH/bin" "${path[@]}")
export GOPROXY="direct"
export GOTOOLCHAIN="local"

# Cargo (Rust)
if [[ -r "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
elif [[ -d "$HOME/.cargo/bin" ]]; then
  path=("$HOME/.cargo/bin" "${path[@]}")
fi

# Python
#[ -e "${HOME}/.local/share/pyenv/bin/activate" ] \
#&& source "${HOME}/.local/share/pyenv/bin/activate"

# Rubygems
if __is_available gem && __is_available ruby; then
  () {
    local gem_dir
    gem_dir=$(ruby -r rubygems -e 'puts Gem.user_dir') || return
    [[ -n "$gem_dir" ]] && path=("$gem_dir/bin" "$HOME/.gem/bin" "${path[@]}")
  }
fi

# NPM
path+=("$HOME/.local/bin")
if __is_available npm; then
  () {
    local npm_prefix
    npm_prefix=$(npm config get prefix --global) || return
    [[ "$npm_prefix" == /* ]] || return 1
    export NPM_PACKAGES="$npm_prefix/lib/node_modules"
    path+=("$npm_prefix/bin")
    # An empty MANPATH component includes the system's default search path.
    local -aU man_dirs=("${(@s/:/)MANPATH}" "$npm_prefix/share/man")
    export MANPATH="${(j/:/)man_dirs}"
  }
fi

# Wayland
if __is_available sway linux
then
  alias sway-launch="dbus-launch --exit-with-session sway"
  alias desk="sway-launch"
  if test -z "${XDG_RUNTIME_DIR}"
  then
    if __private_directory "/run/user/$UID" 2>/dev/null; then
      export XDG_RUNTIME_DIR="/run/user/$UID"
    elif __private_directory "/tmp/${UID}-runtime-dir"; then
      # Fallback for hosts without a session-managed runtime directory.
      export XDG_RUNTIME_DIR="/tmp/${UID}-runtime-dir"
    else
      print -u2 -- 'Cannot establish a private XDG_RUNTIME_DIR.'
    fi
  fi

  export GTK_THEME="Netrunner"
  export GTK2_RC_FILES="${HOME}/.themes/${GTK_THEME}/gtk-2.0/gtkrc"
  #gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Completions                                                                ║
# ╚════════════════════════════════════════════════════════════════════════════╝

autoload -Uz compaudit compinit zrecompile
zmodload -i zsh/complist
ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"

() {
  local lockfd
  if __owned_directory "$ZSH_CACHE_DIR" && zmodload zsh/system; then
    : >> "$ZSH_COMPDUMP.lock"
    if zsystem flock -t 1 -f lockfd "$ZSH_COMPDUMP.lock"; then
      {
        compinit -i -d "$ZSH_COMPDUMP"
        if [[ -f "$ZSH_COMPDUMP" && ( ! -f "$ZSH_COMPDUMP.zwc" ||
              "$ZSH_COMPDUMP" -nt "$ZSH_COMPDUMP.zwc" ) ]]; then
          zrecompile -q -p "$ZSH_COMPDUMP" &&
            command rm -f -- "$ZSH_COMPDUMP.zwc.old"
        fi
      } always {
        zsystem flock -u "$lockfd"
      }
      return
    fi
  fi
  compinit -i -D -d /dev/null
}

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
  "ps -U $USERNAME -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order \
  local-directories directory-stack path-directories
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR/completions"
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


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Autosuggestions                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGESTIONS="${HOME}/.zsh/zsh-autosuggestions"
[[ -r "$ZSH_AUTOSUGGESTIONS/zsh-autosuggestions.zsh" ]] &&
  source "$ZSH_AUTOSUGGESTIONS/zsh-autosuggestions.zsh"


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
  __is_available gpg-connect-agent || return 0
  gpg-connect-agent updatestartuptty /bye &>/dev/null
  return 0
}
autoload -U add-zsh-hook
add-zsh-hook preexec _gpg-agent_update-tty_preexec


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ SSH                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function __ssh_agent_alive() {
  local sock="$1" REPLY
  [[ -S "$sock" ]] || return 1
  zmodload -F zsh/net/socket b:zsocket || return
  zsocket -- "$sock" 2>/dev/null || return 1
  exec {REPLY}>&-
}

function __read_ssh_agent_cache() {
  local cache="$1" line sock pid
  local -A info
  [[ -f "$cache" && ! -L "$cache" && -O "$cache" ]] || return 1
  zmodload -F zsh/stat b:zstat || return
  zstat -H info -- "$cache" || return
  (( (info[mode] & 8#022) == 0 )) || return 1
  while IFS= read -r line; do
    case "$line" in
      SSH_AUTH_SOCK=*) sock=${${line#*=}%%;*}; sock=${(Q)sock} ;;
      SSH_AGENT_PID=*) pid=${${line#*=}%%;*} ;;
    esac
  done < "$cache"
  [[ "$pid" == <-> ]] && __ssh_agent_alive "$sock" || return 1
  export SSH_AUTH_SOCK="$sock" SSH_AGENT_PID="$pid"
}

function _start_agent() {
  __ssh_agent_alive "${SSH_AUTH_SOCK:-}" && return 0
  __is_available ssh-agent || return 1
  [[ -d "$HOME/.ssh" ]] || return 1

  local agent_dir="$ZSH_CACHE_DIR/ssh-$SHORT_HOST"
  local cache="$agent_dir/environment" lockfd output line sock pid tmp=''
  __owned_directory "$ZSH_CACHE_DIR" && __private_directory "$agent_dir" \
  || return 1
  zmodload zsh/system || return
  : >> "$agent_dir/lock"
  zsystem flock -t 3 -f lockfd "$agent_dir/lock" || return
  {
    __read_ssh_agent_cache "$cache" && return 0
    __read_ssh_agent_cache "$HOME/.ssh/environment-$SHORT_HOST" && return 0
    __read_ssh_agent_cache "$HOME/.ssh/environment-" && return 0

    print -u2 -- 'Starting ssh-agent ...'
    output=$(ssh-agent -a "$agent_dir/agent.$$.sock" -s) || return
    for line in "${(@f)output}"; do
      case "$line" in
        SSH_AUTH_SOCK=*) sock=${${line#*=}%%;*} ;;
        SSH_AGENT_PID=*) pid=${${line#*=}%%;*} ;;
      esac
    done
    [[ "$pid" == <-> ]] && __ssh_agent_alive "$sock" || return 1
    export SSH_AUTH_SOCK="$sock" SSH_AGENT_PID="$pid"
    tmp=$(mktemp "$agent_dir/environment.XXXXXX") || return
    printf 'SSH_AUTH_SOCK=%s;\nSSH_AGENT_PID=%s;\n' "$sock" "$pid" > "$tmp" \
    || return
    __replace_file "$tmp" "$cache"
  } always {
    [[ -z "$tmp" ]] || command rm -f -- "$tmp"
    zsystem flock -u "$lockfd"
  }
}

function _add_identities() {
  local id file line sig lines
  local -a identities loaded_sigs loaded_ids not_loaded

  if [[ ! -d "$HOME/.ssh" ]]; then
    return
  fi

  if [[ ${#identities} -eq 0 ]]; then
    for id in id_rsa id_dsa id_ecdsa id_ecdsa_sk id_ed25519 id_ed25519_sk \
        identity; do
      [[ -f "$HOME/.ssh/$id" ]] && identities+=($id)
    done
  fi

  (( ${#identities} )) || return 0

  if lines=$(ssh-add -l 2>/dev/null); then
    for line in ${(f)lines}; do
      loaded_sigs+=${${(z)line}[2]}
      loaded_ids+=${${(z)line}[3]}
    done
  fi

  for id in $identities; do
    [[ "$id" = /* ]] && file="$id" || file="$HOME/.ssh/$id"
    if [[ -f $file && ${loaded_ids[(I)$file]} -le 0 ]]; then
      line=$(ssh-keygen -lf "$file") || return
      sig=${${(z)line}[2]}
      [[ ${loaded_sigs[(I)$sig]} -le 0 ]] && not_loaded+=("$file")
    fi
  done

  if [[ ${#not_loaded} -eq 0 ]]; then
    return
  fi

  ssh-add "${not_loaded[@]}"
}

if __is_available ssh-add && _start_agent; then
  _add_identities
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ FZF                                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function fzf_setup_using_fzf() {
  (( ${+commands[fzf]} )) || return 1

  local fzf_ver integration
  fzf_ver=$(fzf --version) || return
  fzf_ver=${fzf_ver#fzf }

  autoload -Uz is-at-least
  if ! is-at-least 0.48.0 ${${(s: :)fzf_ver}[1]}; then
    print -u2 -- 'fzf shell integration requires fzf 0.48.0 or newer.'
    return 1
  fi

  integration=$(fzf --zsh) || return
  eval "$integration"
}

__is_available fzf && fzf_setup_using_fzf

unset -f -m 'fzf_setup_*'

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Bindkeys                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function __keypad_init() {
    echoti smkx
  }
  function __keypad_finish() {
    echoti rmkx
  }
  autoload -Uz add-zle-hook-widget
  add-zle-hook-widget line-init __keypad_init
  add-zle-hook-widget line-finish __keypad_finish
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


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Global API keys                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if [[ -o login ]] && __is_available pass; then
  () {
    local key
    key=$(pass show coingecko/api-key) && [[ -n "$key" ]] &&
      export COINGECKO_API_KEY="$key"
  }
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Aliases                                                                    ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# https://github.com/zsh-users/zsh/blob/master/Functions/Misc/zmv
autoload -Uz zmv
alias zmv='noglob zmv -vW'

# https://github.com/ajeetdsouza/zoxide
__is_available zoxide \
&& [ "${USER}" != "root" ] \
&& eval "$(zoxide init --cmd cd zsh)" \
&& alias cdd=cdi \
&& alias re='cd -'

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

# https://github.com/helix-editor/helix
__is_available hx \
&& alias ed=hx \
&& alias vi=hx \
&& alias vim=hx \
&& alias nvim=hx \
&& alias helix=hx \
&& export EDITOR="hx"

# https://github.com/junegunn/fzf
__is_available fzf \
&& alias preview='fzf --preview="bat {} --color=always"'

# https://github.com/nerdypepper/eva
__is_available eva \
&& alias calc='eva'

# https://github.com/sharkdp/hexyl
__is_available hexyl \
&& alias hex='hexyl'

# https://github.com/sharkdp/hyperfine
__is_available hyperfine \
&& alias benchmark='hyperfine'

# https://github.com/irssi/irssi
__is_available irssi \
&& alias irc='irssi'

# https://github.com/profanity-im/profanity
__is_available profanity \
&& alias profanity='stty -ixon && profanity'

__is_available xdg-open linux \
&& alias open='xdg-open'

__is_available doas linux \
&& alias fucking='doas' \
|| alias fucking='sudo'

alias root="su -l -- root -c 'exec bash -l'"

alias uuid=uuidgen
alias wget='wget --no-hsts'
alias rmrf='rm -rf'
alias ehco=echo

function tailall() {
  local file
  local -a files
  while IFS= read -r -d '' file; do
    files+=("$file")
  done < <(find /var/log -type f ! -name '*.gz' -print0)
  (( $#files )) || return 1
  command tail -f -- "${files[@]}"
}

alias my-ip="curl http://ipecho.net/plain; echo"

# Journal (https://xn--gckvb8fzb.com)
export JRNL="${MY_PROJECTS_DIR}/xn--gckvb8fzb.com/content"
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

encrypt() (
  emulate -L zsh
  umask 077
  if (( $# != 1 )) || [[ ! -f "$1" || ! -r "$1" || "$1" == *.age ]]; then
    print -u2 -- 'usage: encrypt <readable file without .age suffix>'
    return 1
  fi
  local input="${1:a}" recipient1 recipient2 workdir
  recipient1=$(pass show age/id1) && [[ -n "$recipient1" ]] || return 1
  recipient2=$(pass show age/id2) && [[ -n "$recipient2" ]] || return 1
  workdir=$(mktemp -d "${input:h}/.zsh-encrypt.XXXXXX") || return
  trap 'command rm -f -- "$workdir/output"; command rmdir -- "$workdir"' EXIT
  trap 'exit 130' INT
  trap 'exit 143' TERM
  trap 'exit 129' HUP
  age -r "$recipient1" -r "$recipient2" -o "$workdir/output" "$input" || return
  __replace_file "$workdir/output" "$input.age"
)

decrypt() (
  emulate -L zsh
  umask 077
  if (( $# != 1 )) || [[ ! -f "$1" || ! -r "$1" || "$1" != *.age ]]; then
    print -u2 -- 'usage: decrypt <readable .age file>'
    return 1
  fi
  local input="${1:a}" destination="${${1:a}%.age}" confirmation fd
  local keydir='' workdir=''
  integer overwrite=0 claimed=0
  if [[ -d "$destination" ]]; then
    print -u2 -- "Destination is a directory: $destination"
    return 1
  fi
  if [[ -e "$destination" || -L "$destination" ]]; then
    read -r "confirmation?Replace $destination? [y/N] " || return 1
    [[ "$confirmation" == [yY] || "$confirmation" == [yY][eE][sS] ]] \
    || return 1
    overwrite=1
  fi
  zmodload -F zsh/system b:sysopen || return
  trap 'command rm -rf -- ${keydir:+"$keydir"} ${workdir:+"$workdir"}' EXIT
  trap 'exit 130' INT
  trap 'exit 143' TERM
  trap 'exit 129' HUP
  keydir=$(mktemp -d "${TMPDIR:-/tmp}/zsh-decrypt.XXXXXX") || return
  pass show age/id1-identity > "$keydir/id1" && [[ -s "$keydir/id1" ]] \
  || return 1
  pass show age/id2-identity > "$keydir/id2" && [[ -s "$keydir/id2" ]] \
  || return 1
  workdir=$(mktemp -d "${destination:h}/.zsh-decrypt.XXXXXX") || return
  age -d -i "$keydir/id1" -i "$keydir/id2" -o "$workdir/output" "$input" \
  || return
  command rm -rf -- "$keydir" && keydir=''
  if (( ! overwrite )); then
    if sysopen -w -o excl,creat -u fd -- "$destination" 2>/dev/null; then
      exec {fd}>&-
      claimed=1
    elif [[ -e "$destination" || -L "$destination" ]]; then
      read -r "confirmation?Replace $destination? [y/N] " || return 1
      [[ "$confirmation" == [yY] || "$confirmation" == [yY][eE][sS] ]] \
      || return 1
    else
      print -u2 -- "Cannot create $destination"
      return 1
    fi
  fi
  if ! __replace_file "$workdir/output" "$destination"; then
    (( ! claimed )) || command rm -f -- "$destination"
    return 1
  fi
)


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ encode64/decode64                                                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝

encode64() {
  if [[ $# -eq 0 ]]; then
    base64
  else
    printf '%s' "$1" | base64
  fi
}

encodefile64() {
  if (( $# != 1 )) || [[ ! -f "$1" || ! -r "$1" ]]; then
    print -u2 -- 'usage: encodefile64 <readable filename>'
    return 1
  fi
  base64 < "$1" > "$1.txt" || return
  print -r -- "${1}'s content encoded in base64 and saved as ${1}.txt"
}

decode64() {
  if [[ $# -eq 0 ]]; then
    base64 --decode
  else
    printf '%s' "$1" | base64 --decode
  fi
}
alias e64=encode64
alias ef64=encodefile64
alias d64=decode64


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Mosh/SSH wrapper                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function __mosh_host() {
  emulate -L zsh
  local host="${(L)1}" config="$2" line previous=''
  [[ -r "$config" ]] || return 1
  while IFS= read -r line || [[ -n "$line" ]]; do
    line=${(L)line}
    [[ "$previous" == \#*features:*mosh* && "$line" == "host $host"* ]] &&
      return 0
    previous=$line
  done < "$config"
  return 1
}

function ssh {
  if (( $# == 1 )) && [[ -n "$1" && "$1" != -* ]] &&
      __is_available mosh && __mosh_host "${1##*@}" "$HOME/.ssh/config"; then
    print -u2 -- 'connecting with mosh ...'
    command mosh "$1"
  else
    print -u2 -- 'connecting with ssh ...'
    local term="$TERM"
    [[ "$term" != xterm-ghostty ]] || term=xterm-256color
    TERM="$term" command ssh "$@"
  fi
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Gentoo packages helper                                                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if __is_available equery
then
  function __packages_list() {
    local repo
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

function __require_commands() {
  local program result=0
  for program in "$@"; do
    if ! __is_available "$program"; then
      print -u2 -- "Required command is unavailable: $program"
      result=1
    fi
  done
  return "$result"
}

function __go_tool_paths() {
  local bin info line
  local -a fields
  local -aU packages
  for bin in "${GOPATH:-$HOME/.go}"/bin/*(N-.); do
    info=$(go version -m "$bin") || return
    for line in "${(@f)info}"; do
      fields=("${(@z)line}")
      if [[ "$fields[1]" == path && "$fields[2]" == github.com/* ]]; then
        packages+=("$fields[2]")
      fi
    done
  done
  (( $#packages )) && print -rl -- "${(@o)packages}"
  return 0
}

function update-tools() (
  __require_commands cargo go gh pass vale tldr git || return
  local go_packages package
  go_packages=$(__go_tool_paths) || return

  printf "Updating Rust tools ...\n"
  cargo install-update -a -g || return

  printf "\nUpdating Go tools ...\n"
  unset GOPROXY
  for package in "${(@f)go_packages}"; do
    [[ -n "$package" ]] || continue
    go install "$package@latest" || return
  done

  printf "\nNot updating NPM tools, because NPM is a mess!\n"
  printf "Update at your own risk!\n"
  #npm update -g

  printf "\nUpdating gh extensions ...\n"
  gh extension upgrade --all || return

  printf "\nUpdating vale ...\n"
  vale sync || return

  printf "\nUpdating tealdeer ...\n"
  tldr --update || return

  printf "\nUpdating Zsh plugins ...\n"
  if [[ -d "$HOME/.zsh/zsh-autosuggestions/.git" ]]; then
    git -C "$HOME/.zsh/zsh-autosuggestions" pull --ff-only || return
  fi

  printf "\nTools updated\n"
)


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
  setopt localoptions pipefail
  local dir repo repostatus
  find . -name .git \( -type d -o -type f \) -print0 -prune |
    while IFS= read -r -d '' dir; do
      repo=${dir:h}
      repostatus=$(git -C "$repo" status --short) || return
      [[ -z "$repostatus" ]] || print -r -- "$repo"
    done
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Online tools                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function jitsi-link() {
  local id url
  id=$(uuidgen) || return
  url="https://meet.jit.si/$id"
  printf "%s" "${url}" | wl-copy || return
  printf "%s\n" "${url}"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Multimedia                                                                 ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function video-to-gif() (
  emulate -L zsh
  if (( $# < 2 || $# > 4 )) || [[ ! -f "$1" || ! -r "$1" || -z "$2" ]]; then
    print -u2 -- 'usage: video-to-gif INPUT OUTPUT [FPS [SPEED]]' \
      '(defaults: 10 FPS, 2x)'
    return 1
  fi
  local fps="${3:-10}" speed="${4:-2}" number
  for number in "$fps" "$speed"; do
    if [[ ! "$number" =~ '^([0-9]+([.][0-9]*)?|[.][0-9]+)$' ]] ||
        ! (( number > 0 && number < 1.7976931348623157e308 )); then
      print -u2 -- 'FPS and speed must be positive finite decimal numbers.'
      return 1
    fi
  done
  local input="${1:a}" output="${2:a}" workdir filter
  [[ ! "$input" -ef "$output" && ! -d "$output" ]] || return 1
  workdir=$(mktemp -d "${output:h}/.zsh-gif.XXXXXX") || return
  trap 'command rm -f -- "$workdir/output.gif"
    command rmdir -- "$workdir"' EXIT
  trap 'exit 130' INT
  trap 'exit 143' TERM
  trap 'exit 129' HUP
  filter="[0:v]setpts=(PTS-STARTPTS)/$speed,fps=$fps"
  filter+=",scale=800:-1:flags=lanczos,split[s0][s1]"
  filter+=";[s0]palettegen[p];[s1][p]paletteuse"
  ffmpeg -nostdin -y -i "$input" -filter_complex "$filter" \
    -an -loop 0 "$workdir/output.gif" || return
  __replace_file "$workdir/output.gif" "$output"
)

function rip() {
  if (( $# != 1 )) || [[ -z "$1" ]]; then
    print -u2 -- 'usage: rip <URL>'
    return 1
  fi
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
  local url="$1"
  if [ "$1" = "to" ]
  then 
    url="$2"
  fi 
  [[ -n "$url" ]] || { print -u2 -- 'usage: listen [to] <URL>'; return 1; }

  mpv \
    --quiet \
    --no-video \
    "$url"
}

function __process_image() (
  emulate -L zsh
  local mode="$1" input="${2:a}" workdir output dimensions width height geometry
  local -a resize
  local -A info
  workdir=$(mktemp -d "${input:h}/.zsh-image.XXXXXX") || return
  output="$workdir/output.${input:e}"
  trap 'command rm -f -- "$output"; command rmdir -- "$workdir"' EXIT
  trap 'exit 130' INT
  trap 'exit 143' TERM
  trap 'exit 129' HUP
  if [[ "$mode" == compress ]]; then
    imager -f jpeg -i "$input" -o "$output" || return
  else
    dimensions=$(magick identify -format '%w %h' "$input") || return
    read -r width height <<< "$dimensions"
    [[ "$width" == <-> && "$height" == <-> ]] || return 1
    if (( width < height )); then
      geometry=2160x3840
    else
      geometry=3840x2160
    fi
    [[ "$mode" != scale ]] || resize=(-resize "${geometry}^")
    magick "$input" "${resize[@]}" -gravity NorthWest \
      -crop "${geometry}+0+0" +repage "$output" || return
  fi
  [[ -s "$output" ]] || return 1
  zmodload -F zsh/stat b:zstat || return
  zstat -H info -- "$input" || return
  command chmod -- "$(( [##8] ${info[mode]} & 8#7777 ))" "$output" || return
  __replace_file "$output" "$input"
)

function scale-and-crop-16-9() {
  setopt localoptions pipefail
  local file
  find . -type f -iname "${1:-*.jpg}" -print0 |
    while IFS= read -r -d '' file; do
      __process_image scale "$file" || return
    done
}

function crop-16-9() {
  setopt localoptions pipefail
  local file
  find . -type f -iname '*.jpg' -print0 |
    while IFS= read -r -d '' file; do
      __process_image crop "$file" || return
    done
}

function compress-all-jpgs() {
  setopt localoptions pipefail
  local file
  find . -type f -iname '*.jpg' -size +2097152c -print0 |
    while IFS= read -r -d '' file; do
      __process_image compress "$file" || return
    done
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ gh                                                                         ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function gh() (
  local -x GITHUB_TOKEN
  GITHUB_TOKEN=$(pass show github/token) && [[ -n "$GITHUB_TOKEN" ]] || return 1
  command gh "$@"
)


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Dotfiles management                                                        ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export DOTFILES="${MY_PROJECTS_DIR}/dotfiles"

function dotfiles-update-remote() {
  cp "${HOME}/.zshrc" "${DOTFILES}/.zshrc"
  cp "${HOME}/.motd" "${DOTFILES}/.motd"
  cp "${HOME}/.vale.ini" "${DOTFILES}/.vale.ini"
  cp "${HOME}/.wallpaper" "${DOTFILES}/.wallpaper"
  cp -R "${HOME}/.themes/Netrunner" "${DOTFILES}/.themes/"

  rsync -avH \
    --include-from="${DOTFILES}/.include" \
    "${XDG_CONFIG_HOME}/" "${DOTFILES}/.config/" --delete-before

  mkdir -p "${DOTFILES}/usr/local/bin/"
  rsync -avH \
    --include-from="${DOTFILES}/.include" \
    "/usr/local/" "${DOTFILES}/usr/local/" --delete

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
  cp -R "${DOTFILES}/.themes/Netrunner" "${HOME}/.themes/"

  rsync -avH \
    --include-from="${DOTFILES}/.include" \
    "${DOTFILES}/.config/" "${XDG_CONFIG_HOME}/" 

  cp "${DOTFILES}/usr/local/bin/"* /usr/local/bin/

  return 0
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ motd                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

DOT_MOTD="${HOME}/.motd"
[ -r "${DOT_MOTD}" ] \
&& source "${DOT_MOTD}"


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Stoicism                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if __is_available fortune; then
  fortune stoic
  printf "\n"
fi


__is_available starship \
&& eval "$(starship init zsh)"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Stuff other programs dare to append goes here                              ║
# ╚════════════════════════════════════════════════════════════════════════════╝
#
# ...

# zprof
