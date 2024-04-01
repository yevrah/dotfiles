# Basic terminal setup
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export GREP_OPTIONS='--color=auto'

# Set the prompt: See http://blog.twistedcode.org/2008/03/customizing-your-bash-prompt.html
# 
# Bash Prompt Variables 
# ----------------------
#   Characters prefixed by a backslash (\) are actually variables that get expanded. Here 
#   is a list of all Bash prompt variables as described in the PROMPTING section of the BASH(1) man page. 
#     \a           an ASCII bell character (07)
#     \d           the date in "Weekday Month Date" format (e.g., "Tue May 26")
#     \D{format}   the format is passed to strftime(3) and the result is inserted into the prompt string; an empty format results in a locale-specific time representation. The braces are required.
#     \e           an ASCII escape character (033)
#     \h           the hostname up to the first .
#     \H           the full hostname
#     \j           the number of jobs currently managed by the shell
#     \l           the basename of the shells terminal device name
#     \n           newline
#     \r           carriage return
#     \s           the name of the shell, the basename of $0 (the portion following the final slash)
#     \t           the current time in 24-hour HH:MM:SS format
#     \T           the current time in 12-hour HH:MM:SS format
#     \@           the current time in 12-hour am/pm format
#     \A           the current time in 24-hour HH:MM format
#     \u           the username of the current user
#     \v           the version of bash (e.g., 2.00)
#     \V           the release of bash, version + patch level (e.g., 2.00.0)
#     \w           the current working directory, with $HOME abbreviated with a tilde
#     \W           the basename of the current working directory, with $HOME abbreviated with a tilde
#     \!           the history number of this command
#     \#           the command number of this command
#     \$           if the effective UID is 0, a #, otherwise a $
#     \nnn         the character corresponding to the octal number nnn
#     \\           a backslash
#     \[           begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
#     \]           end a sequence of non-printing characters
#
# Colors
# ------
#  Bash Color Escape Codes 
#  Use any of the following escape codes between \e[ and m to colorize text in Bash: 
#  Black         0;30
#  Dark Gray     1;30
#  Blue          0;34
#  Light Blue    1;34
#  Green         0;32
#  Light Green   1;32
#  Cyan          0;36
#  Light Cyan    1;36
#  Red           0;31
#  Light Red     1;31
#  Purple        0;35
#  Light Purple  1;35
#  Brown         0;33
#  Yellow        1;33
#  Light Gray    0;37
#  White         1;37

# PROMPT_COMMAND='PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u.\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"'

export PS1='\[\033[00;32m\]\u@\h \[\033[00;33m\][ \w ]\[\033[00;32m\]-> \[\033[00m\]'


# FROM http://blog.grahampoulter.com/2011/09/show-current-git-bazaar-or-mercurial.html
## Print nickname for git/hg/bzr/svn version control in CWD
## Optional $1 of format string for printf, default "(%s) "
function be_get_branch {
  local dir="$PWD"
  local vcs
  local nick
  while [[ "$dir" != "/" ]]; do
    for vcs in git hg svn bzr; do
      if [[ -d "$dir/.$vcs" ]] && hash "$vcs" &>/dev/null; then
        case "$vcs" in
          git) __git_ps1 "${1:-(%s) }"; return;;
          hg) nick=$(hg branch 2>/dev/null);;
          svn) nick=$(svn info 2>/dev/null\
                | grep -e '^Repository Root:'\
                | sed -e 's#.*/##');;
          bzr)
            local conf="${dir}/.bzr/branch/branch.conf" # normal branch
            [[ -f "$conf" ]] && nick=$(grep -E '^nickname =' "$conf" | cut -d' ' -f 3)
            conf="${dir}/.bzr/branch/location" # colo/lightweight branch
            [[ -z "$nick" ]] && [[ -f "$conf" ]] && nick="$(basename "$(< $conf)")"
            [[ -z "$nick" ]] && nick="$(basename "$(readlink -f "$dir")")";;
        esac
        [[ -n "$nick" ]] && printf "${1:-(%s) }" "$nick"
        return 0
      fi
    done
    dir="$(dirname "$dir")"
  done
}


## Add branch to PS1 (based on $PS1 or $1), formatted as $2
export GIT_PS1_SHOWDIRTYSTATE=yes
export PS1="\$(be_get_branch "$2")${PS1}";



# Let the cow have the last word
fortune | cowsay


## Bash Aliasas for Drive Operations
function mcd () { mkdir -p "$@" && eval cd "\"\$$#\""; } 



export PATH=/Users/harvey/dev/bin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/mysql/bin:$PATH

##
# Your previous /Users/harvey/.bash_profile file was backed up as /Users/harvey/.bash_profile.macports-saved_2015-02-07_at_09:37:48
##

# MacPorts Installer addition on 2015-02-07_at_09:37:48: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# Prevent multiple terminals from clabbering each other, make history 10k long
# src: https://langui.sh/2009/10/30/improved-bash-history/
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTTIMEFORMAT="%D %T "
export HISTIGNORE="&:ls:exit"
shopt -s histappend

# Additional changes from https://langui.sh/2009/11/02/more-useful-bashterminal-settings/

# Increase max returned items before being prompted. (ie, "Display all 380
# possibilities? (y or n"). You can set the number to whatever you'd like.)"
bind 'set completion-query-items 300'

# Show the list of autocompletion options after the first tab. This prevents
# the beep + second tab behavior.
bind 'set show-all-if-ambiguous on'

# When autocompleting for cd or rmdir, list only directories as choices.
complete -d cd rmdir

. "$HOME/.cargo/env"
