# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Created by newuser for 5.9

# Neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin:/home/zev/.local/bin:/home/zev/bin:/mnt/c/windows/System32/"
export PATH="$HOME/opt/cross/bin:$PATH"
alias n="nvim"
alias n.="nvim ."

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
alias ansi="gv https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797"

# alias
alias cls="clear && cat \$(find -L ~/ascii -type f | shuf -n 1) && ls"
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

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

function winpy() {
    cp *.py /mnt/c/Users/HP/wsl/ && cmd.exe /C python "../Users/HP/wsl/$1"
}

function pyman() {
    local str=$1
    local head tail

    if [[ "$str" == *.* ]]; then
        head=${str%.*}
        tail=${str##*.}
        python3 <<EOF 2> /dev/null | less
try:
    from $head import $tail
except ImportError:
    print("Library not found!")
else:
    help($tail)
EOF
    else
    	echo "help(\"$str\")" | python3 2> /dev/null | less
    fi
}

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

rid() { dir=$1; shift; cd "$dir" || return; "$@"; cd - > /dev/null || return; }

zle -N zle-keymap-select
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

bindkey -a '^?' backward-delete-char

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
bindkey -r '^G'
source ~/fzf-git.sh

alias cd="z"

notify-send() { wsl-notify-send.exe --category $WSL_DISTRO_NAME "${@}"; }

tmux
cls
