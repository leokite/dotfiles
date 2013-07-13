export LANG=ja_JP.UTF-8

# Node
export PATH=$HOME/.nodebrew/current/bin:~/bin:$PATH

# Vim
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias e='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

# Sublime Text2
#export EDITOR='subl -w'
#alias e='subl -w'

setopt no_beep

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
setopt hist_reduce_blanks

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt correct

autoload predict-on
predict-on
autoload -U compinit
compinit

autoload colors
colors

setopt prompt_subst
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function git_prompt_status() {
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✚%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ⚡%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_RENAME="%{$fg[green]%} ♺%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[purple]%} ♒%{$reset_color%}"

  INDEX=$(git status --porcelain -b 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAME$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  echo "$STATUS%{$reset_color%}"
}

function git_prompt_stash_count {
  local count=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
  if [ "$count" -gt 0 ]; then
    echo " ($count)"
  fi
}

function git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
    return
  fi
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  else
     color=%F{yellow}
  fi
  #echo "$color$name$action%f%b"
  echo "[%{$color%}$name$action%f]"
}

PROMPT='
%{${fg[yellow]}%}%~%{${reset_color}%}
[%n@${HOST%%.*}]✔ '
PROMPT2='[%n]> '
#RPROMPT='`git-current-branch``git_prompt_stash_count``git_prompt_status`'
RPROMPT='`git-current-branch``git_prompt_stash_count`'

case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST}\007"
    }
    ;;
esac

export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

case "${OSTYPE}" in
freebsd*|darwin*)
 alias ls="ls -GF"
 ;;
linux*)
 alias ls="ls -F --color"
 ;;
esac

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
