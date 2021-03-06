# load scripts from .bin
export PATH="$HOME/bin:$HOME/betaflight_configurator:$PATH"

# setup go
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
# rust
export PATH="$HOME/.cargo/bin:$PATH"

#export TERM='xterm-256color'
[ -f .zshenv.local ] && source .zshenv.local
source "$HOME/.cargo/env"
