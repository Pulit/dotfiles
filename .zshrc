#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# Customize to your needs...

source ~/.zsh/fzf.zsh

# zsh 起動時にtmuxを起動
[[ -z "$TMUX" && ! -z "$PS1" ]] && exec tmux

# alias関係
setopt complete_aliases

if [ "$(uname)" = 'Darwin' ]; then

   alias ls="ls -G -w"

   alias ll="ls -al -G -w"

   alias tree="tree -C -I '.git'"
else

   alias ls='ls --color=auto '
   alias ll='ls --color=auto -al'
fi

 # autocomplet系
 # autoload -Uz compinit
 # compinit

 #autoload -U  predict-on
 #zle -N predict-on
 #zle -N predict-off
 #zstyle ':predict' verbose 'yes'
 #predict-on

 #setopt auto_cd
 #setopt auto_pushd
 # setopt correct
 #unsetopt correct
 # unsetopt correctall
 # DISABLE_CORRECTION="true"

 setopt nolistbeep
 setopt noautoremoveslash

 # コマンド履歴機能
 HISTFILE=~/.zsh_history
 HISTSIZE=100000
 SAVEHIST=100000
 setopt hist_ignore_dups
 setopt share_history


 #
 #autoload -U colors; colors
 #setopt correct
 #setopt re_match_pcre
 #setopt prompt_subst


 PROMPT="λ "



