# PATH
export PATH=/usr/local/bin:$PATH

export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin


# vim default editor
export EDITOR='vim'


# pyenv settings
eval export PATH="/Users/nx3/.pyenv/shims:${PATH}"
export PYENV_SHELL=zsh
source '/usr/local/Cellar/pyenv/1.1.5/libexec/../completions/pyenv.zsh'
command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}

export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"