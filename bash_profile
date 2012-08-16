#
source ~/bash/git-completion.bash
source ~/bash/prompt
source ~/bash/settings
source ~/bash/aliases
source ~/bash/bash_apparix

if [ -f "$BASH_COMPLETION_PATH" ]; then
	. "$BASH_COMPLETION_PATH"
fi