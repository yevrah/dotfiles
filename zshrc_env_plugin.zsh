#
# AUTO Import Virtual Env When Entering CD
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
        #
        # OLD METHOD: packages=`pip list --format=legacy | sed -e 's/ (.*//g' | column -c $((COLUMNS-45)) | expand`
        packages=`pip list --format freeze | sed -e 's/=.*//g' | column -c $((COLUMNS-45)) | expand`

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
