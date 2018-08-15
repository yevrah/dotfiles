# INSPIRED BY http://jilles.me/badassify-your-terminal-and-shell/


# If you come from bash you might have to change your $PATH.
export PATH=$HOME/dotfiles/bin/:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
autoload -U colors
colors

# Show System Info - use neofect as it's aster
if hash neofetch 2>/dev/null; then
  neofetch
elif hash screenfetch 2>/dev/null; then
  screenfetch
fi


# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew npm)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

PROMPT_1='%{$fg_bold[red]%}➜  %{$reset_color%}'

# user, host, full path, and time/date
# on two lines for easier vgrepping
# entry in a nice long thread on the Arch Linux forums: http://bbs.archlinux.org/viewtopic.php?pid=521888#p521888
PROMPT_2=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %b%{\e[0;34m%}%B[%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;33m%}'%D{"%a %b %d, %H:%M"}%b$'%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B] <$(git_prompt_info)>%{\e[0m%}%b '

# Default
PROMPT=$PROMPT_2
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

# Reset right prompt, on window resize
TRAPWINCH ()
{
    if [[ $COLUMNS -lt 120 ]]; then
      PROMPT=$PROMPT_1
    else
      PROMPT=$PROMPT_2
    fi
}


# Syntax Highlighting
# TO INSTALL: cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Z - easy path changing
if hash brew 2>/dev/null; then
  . `brew --prefix`/etc/profile.d/z.sh
fi


function mcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }



# export PATH="/Users/harvey/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# alias v='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'
# alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim'
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1



# export PYTHONSTARTUP=~/.pythonrc
export DEVBOX='HARVEY'
export PATH=/usr/local/bin:/Users/harvey/dev/bin:/usr/local/mysql/bin:$PATH

# MACPORTS:: https://guide.macports.org/chunked/installing.shell.html
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh





#
# AUTO Impor Virtual Env When Entering CD
#

# Gives the path to the nearest parent env file or nothing if it gets to root
function find_env()
{
    local check_dir=$1

    if [ -z "$check_dir" ]; then
      check_dir=$PWD
    fi

    if [[ "$VIRTUAL_ENV" = "${check_dir}/env" ]]; then
      return
    fi

    if [[ -d "${check_dir}/env" ]]; then
        # Activate this env
        source "${check_dir}/env/bin/activate"


        # A lot is happening here
        #  1. Get list form pip
        #  2. Remove uncecessary information
        #  3. Pip sens out a single list, use column to conver to multiple columns of a width taking into account the logo
        #  4. Column outputs tabs, which breaks design, use expand to conver to spaces
        packages=`pip list --format=legacy | sed -e 's/ (.*//g' | column -c $((COLUMNS-45)) | expand`

        package_table=()
        while read -r line; do
           package_table+=("$line")
        done <<< "$packages"

        version=`python --version`
        activated="${check_dir}/env"
        wpython=`which python`
        pip_version=`pip --version | sed -e 's/ from.*//g'`
        pip_packages=`pip --version | sed -e 's/.*from //g; s/ (.*//g'`

        OUT_LARGE="
          #                  .::::::::::.                ##  ____        _   _                  
          #                .::''::::::::::.              ## |  _ \ _   _| |_| |__   ___  _ __   
          #                :::..:::::::::::              ## | |_) | | | | __| '_ \ / _ \| '_ \  
          #                ''''''''::::::::              ## |  __/| |_| | |_| | | | (_) | | | | 
          #        .::::::::::::::::::::::: ,iiiiii,     ## |_|    \__, |\__|_| |_|\___/|_| |_| 
          #     .:::::::::::::::::::::::::: ,iiiiiiii.   ##        |___/  $version
          #     ::::::::::::::::::::::::::: ,iiiiiiiii   ##
          #     ::::::::::::::::::::::::::: ,iiiiiiiii   ## Activated:   $activated
          #     :::::::::: ,,,,,,,,,,,,,,,,,iiiiiiiiii   ## Python:      $wpython
          #     :::::::::: iiiiiiiiiiiiiiiiiiiiiiiiiii   ## Pip:         $pip_version
          #     '::::::::: iiiiiiiiiiiiiiiiiiiiiiiiii'   ## Packages:    $pip_packages
          #        ':::::: iiiiiiiiiiiiiiiiiiiiiii'      ##              ${package_table[1]}
          #                iiiiiiii,,,,,,,,              ##              ${package_table[2]}
          #                iiiiiiiiiii''iii              ##              ${package_table[3]}
          #                'iiiiiiiiii..ii'              ##              ${package_table[4]}
          #                  'iiiiiiiiii'                ##              ${package_table[5]}"

        OUT_MEDIUM="
          #                 .:::::::.               ##  ____        _   _
          #               .::'':::::::.             ## |  _ \ _   _| |_| |__   ___  _ __
          #               :::..::::::::             ## | |_) | | | | __| '_ \ / _ \| '_ \ 
          #               '''''':::::::             ## |  __/| |_| | |_| | | | (_) | | | |
          #        .::::::::::::::::::: ,iiiii,     ## |_|    \__, |\__|_| |_|\___/|_| |_|
          #     .:::::::::::::::::::::: ,iiiiiii.   ##        |___/  $version
          #     ::::::::::::::::::::::: ,iiiiiiii   ##
          #     ::::::::: ,,,,,,,,,,,,,,iiiiiiiii   ## Activated:$activated
          #     ':::::::: iiiiiiiiiiiiiiiiiiiiii'   ## Python:   $wpython
          #        '::::: iiiiiiiiiiiiiiiiiii'      ## Pip:      $pip_version
          #               iiiiii,,,,,,,             ## Packages: $pip_packages
          #               iiiiiiii''iii             ##           ${package_table[1]}
          #               'iiiiiii..ii'             ##           ${package_table[2]}
          #                 'iiiiiii'               ##           ${package_table[3]}"

        OUT_SMALL="
          #    ##   ____        _   _
          #    ##  |  _ \ _   _| |_| |__   ___  _ __
          #    ##  | |_) | | | | __| '_ \ / _ \| '_ \ 
          #    ##  |  __/| |_| | |_| | | | (_) | | | |
          #    ##  |_|    \__, |\__|_| |_|\___/|_| |_|
          #    ##         |___/  $version
          #                                           
          #    ##  Activated: $activated
          #    ##  Pip:       $pip_version"

        out=$OUT_SMALL
        package_padding="                        "
        package_more_after=10000

        if [[ "$COLUMNS" -gt "125" ]]; then
          package_padding="                                                "
          package_more_after=3
          out=$OUT_MEDIUM
        fi

        if [[ "$COLUMNS" -gt "160" ]]; then
          package_padding="                                                        "
          package_more_after=5
          out=$OUT_LARGE
        fi

        out=${out// ,i/$fg[yellow] ,i}
        out=${out// ,,/$fg[yellow] ,,}
        out=${out// ii/$fg[yellow] ii}
        out=${out// \'i/$fg[yellow] \'i}

        out=${out//\#\#/$reset_color}
        out=${out//          \#    /$fg[blue]}

        echo "$out"

        index=0
        for i in "${package_table[@]}"; do
          let index=index+1
          if [[ "$index" -gt "$package_more_after" ]]; then
          fi
        done

        echo ""

        return
    else
        if [ "$check_dir" = "/" ]; then
            return
        fi
        next=$(dirname "$check_dir")
        find_env "$(dirname "$check_dir")"
    fi
}


autoload -Uz add-zsh-hook
add-zsh-hook -D chpwd find_env
add-zsh-hook chpwd find_env

# auto-detect virtualenv on zsh startup
[[ -o interactive ]] && find_env


