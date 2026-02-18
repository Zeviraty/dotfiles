# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

zstyle ':omz:update' mode disabled  # disable automatic updates

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin:/home/zev/.local/bin:/home/zev/bin:/mnt/c/windows/System32/"
export PATH="$HOME/opt/cross/bin:$PATH"
export EDITOR="nvim"
alias n="nvim"
alias n.="nvim ."
alias leet="nvim leetcode.nvim"

# git
alias ga='git add'
alias gad='ga .'
alias gap='ga --patch'
alias gapd='gad --patch'
alias gb='git branch'
alias gba='gb --all'
alias gc='git commit'
alias gadc='gad && gc'
alias gca='gc --amend --no-edit'
alias gce='gc --amend'
alias gco='git checkout'
alias gcl='git clone --recursive'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gds='gd --staged'
alias gi='git init'
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %G? %an  %ar%C(blue)  %D%n%s%n"'
alias gm='git merge'
alias gn='git checkout -b'  # new branch
alias gp='git push'
alias gr='git reset'
alias gs='git status --short'
alias gu='git pull'
alias gfb='gco $(gb | fzf)'

# GH cli
alias gvi="gh issue view \$(gh issue list | fzf | grep -o '^[0-9]\+')" # View issue
alias gg="gh gist"
alias gv="gg view"

# Gists
alias ansi="gv https://gist.github.com/ConnerWill/d4b6c776b509add763e17f9f113fd25b"

# alias
alias cls="clear && cat \$(find -L ~/ascii -type f | shuf -n 1) && ls"
alias bat="batcat"
#alias python="python3"
alias ppi="python3 ~/python/ppi/main.py"
alias ppd="python3 ~/python/ppi/docker.py"
alias clean='d=$(basename "$PWD") && cd .. && rm -rf "$d" && mkdir "$d" && cd "$d"'
alias python3-tk='/usr/local/bin/python3.13'

# Starship
eval "$(starship init zsh)"

# Plugins
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Vim mode
#bindkey -v
bindkey -e
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

# Crude function to run python in windows
function winpy() {
    cp *.py /mnt/c/Users/HP/wsl/ && cmd.exe /C python "../Users/HP/wsl/$1"
}

function nogil() {
    PATH="/opt/python3-nogil/bin:$PATH" "$@"
}

# Python help function (basically pydoc but i made it before i knew that existed)
function pyman() {
    echo "help(\"$1\")" | python3 2> /dev/null | less
}

# View an rfc document
function rfc() {
  local url="https://www.rfc-editor.org/rfc/rfc$1.txt"
  local code

  code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

  if [[ "$code" == "200" ]]; then
    curl -s "$url" | less
  else
    echo "RFC: $1 not found"
  fi
}

# Find an rfc using fzf
function fzrfc() {
    local index=$(curl -s "https://www.rfc-editor.org/rfc-index.txt")
    local chosen=$(awk '
/^[0-9]{4}/ {
  if (out != "") {
    print out
  }
  out = $0
  next
}
NF {
  sub(/^[ \t]+/, "", $0)
  out = out " " $0
  next
}
!NF {
  if (out != "") {
    print out
    out = ""
  }
  next
}
END {
  if (out != "") print out
}
' <<< "$index" | sed -e '1,20d' | fzf | cut -c1-5)
    rfc $(echo $chosen | awk '{$1=$1};1')
}

# Read a pep document
function pep() {
  local url="https://raw.githubusercontent.com/python/peps/refs/heads/main/peps/pep-$1.rst"
  local code

  code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

  if [[ "$code" == "200" ]]; then
    curl -s "$url" | less
  else
    echo "PEP not found"
  fi
}

# Pip install
pi() { pip install $@ --break-system-packages; }

rid() { dir=$1; shift; cd "$dir" || return; "$@"; cd - > /dev/null || return; }

# zsh cursor
zle -N zle-keymap-select
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

bindkey -a '^?' backward-delete-char

# Zoxide
eval "$(zoxide init zsh)"

# fzf
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
bindkey -r '^G'
source ~/fzf-git.sh

# z
alias cd="z"

# auto complete
autoload -Uz compinit && compinit

if [ -f "$HOME/.secrets" ]; then
    source "$HOME/.secrets"
fi

. "$HOME/.cargo/env"

# send notification
notify-send() { wsl-notify-send.exe --category $WSL_DISTRO_NAME "${@}"; }

# shell startup commands
tmux
cls
