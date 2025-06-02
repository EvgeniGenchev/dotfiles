export EDITOR='nvim'
export VISUAL='nvim'

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# XDG NINJA SUGGESTIONS
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc 
export W3M_DIR="$XDG_DATA_HOME"/w3m
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export FLY_CONFIG_DIR="$XDG_STATE_HOME"/fly
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export KERAS_HOME="${XDG_STATE_HOME}/keras"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export HISTFILE="/home/gena/.cache/zsh/history"


export TERM="xterm-256color"
export CLASSPATH="/home/gena/aspectj1.9/lib/aspectjrt.jar:$CLASSPATH"
export PATH="/home/gena/aspectj1.9/bin:$PATH"
export PATH="$HOME/.scripts:$PATH"
export NVM_DIR="$HOME/.config/nvm"
export DOCKER_HOST=unix:///var/run/docker.sock
