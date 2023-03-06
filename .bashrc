#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

#source ~/.bash-powerline.sh

eval "$(starship init bash)"


~/./my_utils/fetch
alias ls='ls --color=auto'
alias ccat='highlight'
alias supy='sudo python'
alias sumake='sudo make'
alias esp='sudo python ~/.config/esptool/esptool.py'
alias py='python'
alias ra='ranger'
alias vi='nvim'
alias tre='tree -C'
alias doit='~/.local/bin/dooit'
alias celeste='~/games/Celeste/start.sh'

# My custom utils
alias rabota="cd workspace/work/3DPrinterPantheon/ & source workspace/work/3DPrinterPantheon/env/bin/activate"
alias lls="python ~/my_utils/ls.py"
alias hx="lua ~/my_utils/hex.lua"
alias mkp="lua ~/my_utils/mkprj.lua"
alias ipmap="~/my_utils/ipsweep.sh"
alias hawk="~/my_utils/hawk"
alias iphawk="~/my_utils/ipswp"
alias actv='~/my_utils/actv'

export EDITOR='nvim'
export VISUAL='nvim'

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
export HISTFILE="${XDG_STATE_HOME}/bash/history"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export PATH="/home/gena/.local/share/cargo/bin:$PATH"
export PATH="/home/gena/.local/bin/:$PATH"

export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR=1.5
