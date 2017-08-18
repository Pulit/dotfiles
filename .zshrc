# zsh 起動時にtmuxを起動
[[ -z "$TMUX" && ! -z "$PS1" ]] && exec tmux
