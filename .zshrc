# zsh 起動時にtmuxを起動
[[ -z "$TMUX" && ! -z "$PS1" ]] && exec tmux


# alias関係
setopt complete_aliases
alias ls="ls -G -w"
alias tree="tree -C -I '.git'"
# autocomplet系
autoload -U compinit
compinit

autoload predict-on
predict-on

setopt auto_cd
setopt auto_pushd
setopt correct
setopt nolistbeep
setopt noautoremoveslash

# コマンド履歴機能
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history


