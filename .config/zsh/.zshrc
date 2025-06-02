# Evgeni's config for the Zoomer Shell

autoload -U colors && colors
eval "$(starship init zsh)"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

autoload -U compinit
setopt nocaseglob
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Zoxide completion
eval "$(zoxide init zsh)"


# vi mode
bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
	     [[ ${KEYMAP} == viins ]] ||		
	     [[ ${KEYMAP} == '' ]] ||
	     [[ $1 == 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}

zle-line-init() {
	zle -K viins
	echo -ne '\e[5 q'
}

zle -N zle-keymap-select
zle -N zle-line-init

echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# Load aliases:

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"


source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

source /home/gena/.local/share/cargo/env

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

[[ ! -r '/home/gena/.opam/opam-init/init.zsh' ]] || source '/home/gena/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
