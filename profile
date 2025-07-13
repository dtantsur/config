export GOPATH="$HOME/.gopath"
export EDITOR=vim
xbindkeys
if test -f "$HOME/.cargo/env"; then
    . "$HOME/.cargo/env"
fi
