# .bashrc
# https://github.com/bcorcoran/bash-environment

SYS=`uname -s`

if command -v git >/dev/null 2>&1 ; then
	
	GIT_INSTALLED=1
	
	# Get git branch for PS1
	parse_git_branch () {
		local BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
		if [ -n "$BRANCH" ] ; then
			echo -n "$BRANCH"
		fi
	}
fi

# Compile PS1
compile_prompt() {

	CMDSTATUS=$?
	
	if [ $GIT_INSTALLED -eq 1 ] ; then
		GITBRANCH=`parse_git_branch`
	fi 
	
	# Set terminal tab title
	# echo -ne "\033]0;${USER}@`hostname -s`:${PWD}\007" # user@host:pwd
	echo -ne "\033]0; `hostname -s`:${PWD}\007" # host:pwd
	
	# Clear out default PS1 prompt
	PS1=''

	# Now start adding to PS1 prompt
	if [ $GIT_INSTALLED -eq 1 ] ; then 
		PS1+="\[\033[1;30m\]git(${GITBRANCH}) " # git branch
	fi
	PS1+="\[\033[1;34m\]\w\[\033[0m\]\n" # pwd
	PS1+="\[\033[0;37m\][\[\033[1;37m\]\!\[\033[0;37m\]]\[\033[0m\] " # command history number
	PS1+="\[\033[1;33m\]\u"
	PS1+="\[\033[1;37m\]@"
	PS1+="\[\033[0;36m\]\h"
	if [ "$CMDSTATUS" -ne 0 ] ; then
		PS1+="\[\033[1;31m\] \$ \[\033[0m\]"
	else
		PS1+="\[\033[1;32m\] \$ \[\033[0m\]"
	fi
	
	PS1+="\[\033[0;32m\]>\[\033[0m\] "
	
}

export PROMPT_COMMAND=compile_prompt

# Mac Environment
if [ "$SYS" == "Darwin" ] ; then
	alias showhidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
	alias noshowhidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
	alias lsrebuild='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user ; killall Dock'
	
	# Homebrew Stuff
	if command -v brew >/dev/null 2>&1; then
		# Prevent running through mac bash by accident
		if command -v $(brew --prefix)/bin/bash >/dev/null 2>&1; then
			alias sh=$(brew --prefix)'/bin/bash'
		fi
		
		# Paths for Homebrew
		export PATH=/usr/local/bin:/usr/local/sbin:$PATH
	fi
fi

alias ll='ls -lah'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

# History Settings
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoredups:ignorespace
export HISTFILESIZE=2000
export HISTSIZE=1000

# Colors
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
