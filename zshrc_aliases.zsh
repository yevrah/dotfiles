
# alias help
function ahelp {
    cat <<EOF

        documented aliases and functions
        -------------------------------------------------------------------
        mcd         : create and cd into folder
        ws          : create a static webserver
        mt          : open marktext editor

        :q          : run exit command
        :e          : open neovim and edit file if available, eg \`:e /etc/my.cnf\`
        :tab        : new tab in iterm
        :split      : split iterm window
        :vsplit     : vertical split iterm window
        :h, :help   : man shortcut, eg \`:h find\`
        :find       : find file and open files (using fzf) and open in \$EDITOR
        :findw      : fine executable (using which) and open in \$EDITOR

        ofd         : open cwd in finder window
        pfd         : Return the path of the frontmost Finder window
        pfs         : Return the current Finder selection
        cdf         : cd to the current Finder directory
        pushdf      : pushd to the current Finder directory

        dps         : list all containes
        dr          : remove - all containers (ps -aq)
        ds          : stop   - all containes
        di          : list   - all images
        dri         : remove - all images
        dsc         : system clean and prune
        dsr         : clean  - stop and remove all containers
        dcup        : start  - start docker compose stack
        dlsn        : disable time machine local snapshots to improve docker disk usage

        tab         : new iterm tab
        tabv        : vertical split
        tabh        : horizontal split

        whois-grep  : Check if domain is available, eg 'whois-grep google.com' (wg for short)
        npm-do      : run locally installed npm binary

        quick-look  : Quick-Look a specified file
        man-preview : Open a specified man page in Preview app
        showfiles   : Show hidden files
        hidefiles   : Hide the hidden files
        itunes      : Control iTunes. Use itunes -h for usage details
        rmdsstore   : Remove .DS_Store files recursively in a directory
        -------------------------------------------------------------------
EOF
}

# My aliases {{{1
alias l="ls -lahF"
alias mcd=mkdir_and_cd
alias pf="fzf --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"
alias pyc="open -na \"PyCharm.app\" --args \"$@\""

# Download page as markdown: https://github.com/bevacqua/hget
hget() { /usr/local/bin/hget $1 --markdown }
npm-do() { eval "$(npm bin)/$@" }

# Open Marktext Markdown Editor
mt() {open -a /Applications/MarkText.app ./$1}

# Binds to port '0' which is a shortcut which asks the kernel to allocate a port from it's ip_local_port_range
# alias ws="python2.7 -m SimpleHTTPServer 0"
alias ws=ws-with-cors

# Check domain available
whois-grep () {
    whois $1 | if ! grep "No match"; then; echo "Domain $1 found" >&2; fi
}

alias wg=whois-grep

# Show/hide hidden files in the Finder
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# docker helpers
alias dps='docker ps -aq'
alias dr='docker rm $(docker ps -aq)'
alias ds='docker stop $(docker ps -aq)'
alias dsc='docker system prune -a; docker system prune --volumes'

alias di='docker images'
alias dri='docker rmi $(docker images -q)'

alias dsr='ds && dr'
alias dps='docker ps -a'
alias dcup='docker-compose up'
alias dlsn='sudo tmutil disable localsnapshot'

# vim like aliases - why not!
alias :q=exit
alias :e=nvim
alias :tab=tab
alias :split=tabh
alias :vsplit=tabv
alias :h=man
alias :help=man
alias :find=editor_find
alias :findw=editor_which


# alias helpers
function editor_which() {
    eval $EDITOR $(which $1)
}

function editor_find() {
    if [[ -n "$1" ]]; then
        eval "find . -iname '*$1*' -exec $EDITOR {} +"
    else
        eval "$EDITOR $(fzf)"
    fi
}

function mkdir_and_cd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# Based on osx zsh plugins {{{1

# Iterm tabs, and split panes {{{2
function _omz_osx_get_frontmost_app() {
  local the_app=$(
    osascript 2>/dev/null <<EOF
      tell application "System Events"
        name of first item of (every process whose frontmost is true)
      end tell
EOF
  )
  echo "$the_app"
}

function tab() {
  # Must not have trailing semicolon, for iTerm compatibility
  local command="cd \\\"$PWD\\\"; clear"
  (( $# > 0 )) && command="${command}; $*"

  local the_app=$(_omz_osx_get_frontmost_app)

  if [[ "$the_app" == 'Terminal' ]]; then
    # Discarding stdout to quash "tab N of window id XXX" output
    osascript >/dev/null <<EOF
      tell application "System Events"
        tell process "Terminal" to keystroke "t" using command down
      end tell
      tell application "Terminal" to do script "${command}" in front window
EOF

  elif [[ "$the_app" == 'iTerm' ]]; then
    osascript <<EOF
      tell application "iTerm"
        set current_terminal to current terminal
        tell current_terminal
          launch session "Default Session"
          set current_session to current session
          tell current_session
            write text "${command}"
          end tell
        end tell
      end tell
EOF

  elif [[ "$the_app" == 'iTerm2' ]]; then
      osascript <<EOF
        tell application "iTerm2"
          tell current window
            create tab with default profile
            tell current session to write text "${command}"
          end tell
        end tell
EOF

  else
    echo "tab: unsupported terminal app: $the_app"
    false

  fi
}

function tabv() {
  local command="cd \\\"$PWD\\\"; clear"
  (( $# > 0 )) && command="${command}; $*"

  local the_app=$(_omz_osx_get_frontmost_app)

  if [[ "$the_app" == 'iTerm' ]]; then
    osascript <<EOF
      -- tell application "iTerm" to activate
      tell application "System Events"
        tell process "iTerm"
          tell menu item "Split Vertically With Current Profile" of menu "Shell" of menu bar item "Shell" of menu bar 1
            click
          end tell
        end tell
        keystroke "${command} \n"
      end tell
EOF

  elif [[ "$the_app" == 'iTerm2' ]]; then
      osascript <<EOF
        tell application "iTerm2"
          tell current session of first window
            set newSession to (split vertically with same profile)
            tell newSession
              write text "${command}"
              select
            end tell
          end tell
        end tell
EOF

  else
    echo "$0: unsupported terminal app: $the_app" >&2
    false

  fi
}

function tabh() {
  local command="cd \\\"$PWD\\\"; clear"
  (( $# > 0 )) && command="${command}; $*"

  local the_app=$(_omz_osx_get_frontmost_app)

  if [[ "$the_app" == 'iTerm' ]]; then
    osascript 2>/dev/null <<EOF
      tell application "iTerm" to activate
      tell application "System Events"
        tell process "iTerm"
          tell menu item "Split Horizontally With Current Profile" of menu "Shell" of menu bar item "Shell" of menu bar 1
            click
          end tell
        end tell
        keystroke "${command} \n"
      end tell
EOF

  elif [[ "$the_app" == 'iTerm2' ]]; then
      osascript <<EOF
        tell application "iTerm2"
          tell current session of first window
            set newSession to (split horizontally with same profile)
            tell newSession
              write text "${command}"
              select
            end tell
          end tell
        end tell
EOF

  else
    echo "$0: unsupported terminal app: $the_app" >&2
    false

  fi
}

# Finder operations {{{2
function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

function pfs() {
  osascript 2>/dev/null <<EOF
    set output to ""
    tell application "Finder" to set the_selection to selection
    set item_count to count the_selection
    repeat with item_index from 1 to count the_selection
      if item_index is less than item_count then set the_delimiter to "\n"
      if item_index is item_count then set the_delimiter to ""
      set output to output & ((item item_index of the_selection as alias)'s POSIX path) & the_delimiter
    end repeat
EOF
}

function cdf() {
  cd "$(pfd)"
}

function pushdf() {
  pushd "$(pfd)"
}

function quick-look() {
  (( $# > 0 )) && qlmanage -p $* &>/dev/null &
}

# Misc {{{2
function man-preview() {
  man -t "$@" | open -f -a Preview
}
compdef _man man-preview


# iTunes control function
function itunes() {
	local opt=$1
	local playlist=$2
	shift
	case "$opt" in
		launch|play|pause|stop|rewind|resume|quit)
			;;
		mute)
			opt="set mute to true"
			;;
		unmute)
			opt="set mute to false"
			;;
		next|previous)
			opt="$opt track"
			;;
		vol)
			opt="set sound volume to $1" #$1 Due to the shift
			;;
		playlist)
		# Inspired by: https://gist.github.com/nakajijapan/ac8b45371064ae98ea7f
if [[ ! -z "$playlist" ]]; then
                    		osascript -e 'tell application "iTunes"' -e "set new_playlist to \"$playlist\" as string" -e "play playlist new_playlist" -e "end tell" 2>/dev/null;
				if [[ $? -eq 0 ]]; then
					opt="play"
				else
					opt="stop"
				fi
                  else
                    opt="set allPlaylists to (get name of every playlist)"
                  fi
                ;;
		playing|status)
			local state=`osascript -e 'tell application "iTunes" to player state as string'`
			if [[ "$state" = "playing" ]]; then
				currenttrack=`osascript -e 'tell application "iTunes" to name of current track as string'`
				currentartist=`osascript -e 'tell application "iTunes" to artist of current track as string'`
				echo -E "Listening to $fg[yellow]$currenttrack$reset_color by $fg[yellow]$currentartist$reset_color";
			else
				echo "iTunes is" $state;
			fi
			return 0
			;;
		shuf|shuff|shuffle)
			# The shuffle property of current playlist can't be changed in iTunes 12,
			# so this workaround uses AppleScript to simulate user input instead.
			# Defaults to toggling when no options are given.
			# The toggle option depends on the shuffle button being visible in the Now playing area.
			# On and off use the menu bar items.
			local state=$1

			if [[ -n "$state" && ! "$state" =~ "^(on|off|toggle)$" ]]
			then
				print "Usage: itunes shuffle [on|off|toggle]. Invalid option."
				return 1
			fi

			case "$state" in
				on|off)
					# Inspired by: https://stackoverflow.com/a/14675583
					osascript 1>/dev/null 2>&1 <<-EOF
					tell application "System Events" to perform action "AXPress" of (menu item "${state}" of menu "Shuffle" of menu item "Shuffle" of menu "Controls" of menu bar item "Controls" of menu bar 1 of application process "iTunes" )
EOF
					return 0
					;;
				toggle|*)
					osascript 1>/dev/null 2>&1 <<-EOF
					tell application "System Events" to perform action "AXPress" of (button 2 of process "iTunes"'s window "iTunes"'s scroll area 1)
EOF
					return 0
					;;
			esac
			;;
		""|-h|--help)
			echo "Usage: itunes <option>"
			echo "option:"
			echo "\tlaunch|play|pause|stop|rewind|resume|quit"
			echo "\tmute|unmute\tcontrol volume set"
			echo "\tnext|previous\tplay next or previous track"
			echo "\tshuf|shuffle [on|off|toggle]\tSet shuffled playback. Default: toggle. Note: toggle doesn't support the MiniPlayer."
			echo "\tvol\tSet the volume, takes an argument from 0 to 100"
			echo "\tplaying|status\tShow what song is currently playing in iTunes."
			echo "\tplaylist [playlist name]\t Play specific playlist"
			echo "\thelp\tshow this message and exit"
			return 0
			;;
		*)
			print "Unknown option: $opt"
			return 1
			;;
	esac
	osascript -e "tell application \"iTunes\" to $opt"
}


# Remove .DS_Store files recursively in a directory, default .
function rmdsstore() {
	find "${@:-.}" -type f -name .DS_Store -delete
}


# Create crypt file
function x() {
    touch $1
    ccrypt -e "$1"
}
