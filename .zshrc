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

setopt nolistbeep
setopt noautoremoveslash

# コマンド履歴機能
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history

PROMPT="λ "



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/nx3/.sdkman"
[[ -s "/Users/nx3/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/nx3/.sdkman/bin/sdkman-init.sh"
