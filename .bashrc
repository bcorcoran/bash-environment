# .bashrc for Mac
# Author: Brendan Corcoran
# This file assumes you have Homebrew (http://brew.sh/) installed.

# Get git branch for PS1
parse_git_branch () {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Make PS1
make_prompt() {

	CMDSTATUS=$?

	# Set terminal tab title
	# echo -ne "\033]0;${USER}@${HOSTNAME}\007"' # remote title
	echo -ne "\033]0;\u2622 ${PWD}\007" # local title

	# Clear out default PS1 prompt
	PS1=''

	# Now start adding to PS1 prompt
	PS1+="\[\033[1;34m\]`parse_git_branch`"
	PS1+="\[\033[0;37m\][\[\033[1;37m\]\!\[\033[0;37m]\]" # command history
	PS1+="\[\033[0;37m\]["
		PS1+="\[\033[1;33m\]\u"
		PS1+="\[\033[1;37m\]@"
		PS1+="\[\033[0;36m\]\h"
		PS1+="\[\033[1;37m\]: "
		PS1+="\[\033[1;34m\]\w"
	PS1+="\[\033[0;37m\]]"

	if [ "$CMDSTATUS" -ne 0 ] ; then
		PS1+="\[\033[1;31m\] \$ "
	else
		PS1+="\[\033[32m\] \$ "
	fi

	PS1+="\[\033[0m\]"
}

export PROMPT_COMMAND=make_prompt

# Aliases
alias showhidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias noshowhidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
if command -v $(brew --prefix)/bin/bash >/dev/null 2>&1; then
	alias sh=$(brew --prefix)'/bin/bash' # prevent running through old bash by accident
fi
alias ll='ls -lah'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias gs='git status'

# MISC
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoredups:ignorespace
export HISTFILESIZE=2000
export HISTSIZE=1000
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Paths for
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
