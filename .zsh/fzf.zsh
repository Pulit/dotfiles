frepo() {
  local dir
    dir=$(ghq list > /dev/null | fzf-tmux --ansi +m) &&
          cd $(ghq root)/$dir
 }

