#

if [[ -f "$HOME/.bash_prompt.$USER" ]]; then
	source "$HOME/.bash_prompt.$USER"
else
	source ~/.bash/prompt
fi

source ~/.bash/settings
source ~/.bash/aliases
source ~/.bash/functions
source ~/.bash/bash_apparix

if [ -f "$BASH_COMPLETION_PATH" ]; then
	. "$BASH_COMPLETION_PATH"
fi

if [ -f "$HOME/.bash_profile.$USER" ]; then
	. "$HOME/.bash_profile.$USER"
fi