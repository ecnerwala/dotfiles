#eval "$(termium shell-hook show pre)"
export DEFAULT_USER=andrew

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bureau"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

#NVM_LAZY=1

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history bgnotify)

source $ZSH/oh-my-zsh.sh

# User configuration

setopt NO_BG_NICE

export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

bindkey "${terminfo[kcuu1]}" up-line-or-local-search
bindkey "${terminfo[kcud1]}" down-line-or-local-search

up-line-or-local-search() {
    zle set-local-history 1
    zle up-line-or-search
    zle set-local-history 0
}
zle -N up-line-or-local-search
down-line-or-local-search() {
    zle set-local-history 1
    zle down-line-or-search
    zle set-local-history 0
}
zle -N down-line-or-local-search

_gen_fzf_default_opts_solarized() {
  local base03="8"
  local base02="0"
  local base01="10"
  local base00="11"
  local base0="12"
  local base1="14"
  local base2="7"
  local base3="15"
  local yellow="3"
  local orange="9"
  local red="1"
  local magenta="5"
  local violet="13"
  local blue="4"
  local cyan="6"
  local green="2"

  # Solarized Dark color scheme for fzf
  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base1,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  "
}
if [[ "$TERM" == "rxvt-unicode-256color" || "$TERM" == "xterm-termite" || "$TERM" == "alacritty" || "$TERM" == "xterm-kitty" ]]; then
  _gen_fzf_default_opts_solarized
fi
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh

[[ -e ~/.dircolors ]] && eval `dircolors ~/.dircolors`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

alias mv='mv -i'

alias e='vim'
alias cls='clear -x'

alias open='xdg-open'
alias ko='konsole -e'

alias pianobar='rm ~/.config/pianobar/out; pianobar | tee ~/.config/pianobar/out'

alias kpcli-my='kpcli --kdb=/home/andrew/Dropbox/keepass2/Database.kdbx --key=/home/andrew/Dropbox/keepass2/pwsafe.key'

alias rxvt-unicode='urxvt'

alias oldvim="/usr/bin/vim"
alias vim="/usr/bin/nvim"

alias mosh-athena='mosh --server="athrun mosh_project mosh-server"'

alias dbx='dropbox-cli'

alias term='(setsid i3-sensible-terminal &>/dev/null &)'

unalias gp

unset SSH_ASKPASS

function mkcd {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
	cd $1
  else
    md $1 && cd $1
  fi
}

unset GREP_OPTIONS

export PATH=$PATH:~/.yarn/bin

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH="$HOME/.local/6828-qemu/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.luarocks/bin:$PATH"

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

eval "$(direnv hook zsh)"

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

#export NODE_OPTIONS=--openssl-legacy-provider

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
#
# virtualenv wrapper setup
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
#source /usr/bin/virtualenvwrapper_lazy.sh
pyenv virtualenvwrapper_lazy

if [ -n "$VIRTUAL_ENV" ]; then
  . "$VIRTUAL_ENV/bin/activate"
else
  #workon default
fi


#ulimit -s 131072

export PATH="$PATH:/home/andrew/.foundry/bin"

export PATH="/home/andrew/.local/share/solana/install/active_release/bin:$PATH"

export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:$HOME/.elan/bin"
#eval "$(termium shell-hook show post)"
