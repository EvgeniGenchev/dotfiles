#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

#source ~/.bash-powerline.sh

eval "$(starship init bash)"


cfetch
alias ls='ls --color=auto'
alias ccat='highlight'
alias supy='sudo python'
alias sumake='sudo make'
alias esp='sudo python ~/.config/esptool/esptool.py'
alias py='python'
alias ra='ranger'
alias vi='nvim'
alias tre='tree -C'

# My custom utils
alias lls="python ~/my_utils/ls.py"
alias hx="lua ~/my_utils/hex.lua"
alias mkp="lua ~/my_utils/mkprj.lua"
alias ipmap="~/my_utils/ipsweep.sh"

export EDITOR='nvim'
