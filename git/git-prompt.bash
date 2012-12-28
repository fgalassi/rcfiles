#!bash

# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
# returns text to add to bash PS1 prompt (includes branch name)
__git_ps1 ()
{
	local g="$(__gitdir)"
	if [ -n "$g" ]; then
		local r=""
		local b=""
		if [ -f "$g/rebase-merge/interactive" ]; then
			r="|REBASE-i"
			b="$(cat "$g/rebase-merge/head-name")"
		elif [ -d "$g/rebase-merge" ]; then
			r="|REBASE-m"
			b="$(cat "$g/rebase-merge/head-name")"
		else
			if [ -d "$g/rebase-apply" ]; then
				if [ -f "$g/rebase-apply/rebasing" ]; then
					r="|REBASE"
				elif [ -f "$g/rebase-apply/applying" ]; then
					r="|AM"
				else
					r="|AM/REBASE"
				fi
			elif [ -f "$g/MERGE_HEAD" ]; then
				r="|MERGING"
			elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
				r="|CHERRY-PICKING"
			elif [ -f "$g/BISECT_LOG" ]; then
				r="|BISECTING"
			fi

			b="$(git symbolic-ref HEAD 2>/dev/null)" || {

				b="$(
				case "${GIT_PS1_DESCRIBE_STYLE-}" in
				(contains)
					git describe --contains HEAD ;;
				(branch)
					git describe --contains --all HEAD ;;
				(describe)
					git describe HEAD ;;
				(* | default)
					git describe --tags --exact-match HEAD ;;
				esac 2>/dev/null)" ||

				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)" ||
				b="unknown"
			}
		fi

		local w=""
		local i=""
		local s=""
		local u=""
		local c=""
		local p=""

		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
				c="BARE:"
			else
				b="GIT_DIR!"
			fi
		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
					git diff --no-ext-diff --quiet --exit-code || w="*"
					if git rev-parse --quiet --verify HEAD >/dev/null; then
						git diff-index --cached --quiet HEAD -- || i="+"
					else
						i="#"
					fi
				fi
			fi
			if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
			        git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
			fi

			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
			   if [ -n "$(git ls-files --others --exclude-standard)" ]; then
			      u="%"
			   fi
			fi

			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
				__git_ps1_show_upstream
			fi
		fi

		local f="$i$w$u$s"
		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
	fi
}


       RED="\[\033[0;31m\]"
    YELLOW="\[\033[0;33m\]"
	 GREEN="\[\033[0;32m\]"
      CYAN="\[\033[0;36m\]"
COLOR_NONE="\[\e[0m\]"


function git_prompt() {
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUPSTREAM="auto"
    git_prompt=$(__git_ps1)
    if [[ -n git_prompt ]]; then
        git_prompt=${git_prompt//\+/${GREEN}A${COLOR_NONE}}
        git_prompt=${git_prompt//\*/${RED}M${COLOR_NONE}}
        git_prompt=${git_prompt//%/${RED}?${COLOR_NONE}}
        git_prompt=${git_prompt//<>/${YELLOW}↕${COLOR_NONE}}
        git_prompt=${git_prompt//>/${YELLOW}↑${COLOR_NONE}}
        git_prompt=${git_prompt//</${YELLOW}↓${COLOR_NONE}}
        git_prompt=${git_prompt//\$/${CYAN}S${COLOR_NONE}}
        git_prompt=${git_prompt//=/}
    fi
    echo "$git_prompt "
}

function set_prompt() {
    PS1="[\t] \u@\h \w$(git_prompt)$ "
}

PROMPT_COMMAND=set_prompt
