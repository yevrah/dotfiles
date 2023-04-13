#!/bin/bash

#=== BANNER ================================================================== {{{1
##
## Script
##
##    This script...
##


#=== SCRIPT MAIN ============================================================= {{{1
set -e
export TERM=xterm

main () {
    banner
}


#=== SCRIPT FUNCTIONS ======================================================== {{{1



#=== SCRIPT HELPERS ========================================================== {{{1

banner () {
    MSG="$1"

    clear
    grep '^##' $0 | grep -v 'grep' | sed 's/##/  /'

    echo ""
}

continue () {
    printf "\n\n"
    read -p "Please review and press ENTER to continue. Ctrl-C to bail." entered
}

check_root () {
    if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
        exit
    fi
}



#=== BOOTSTRAP SCRIPT ======================================================== {{{1

main "$@"; exit
exit

#=== DOCUMENTATION =========================================================== {{{1
: << __DATA_SECTION__

    USING FFMPEG - https://ffmpeg.org/ (SO: 326388)
    ==================================================

    You can capture the audio as a stream through Apple's AVFoundation.

    Get the device ID
    --------------------------------------------------

    ```
    $ ffmpeg -f avfoundation -list_devices true -i ""

    [AVFoundation input device @ 0x7fda1bc152c0] AVFoundation video devices:
    [AVFoundation input device @ 0x7fda1bc152c0] [0] FaceTime HD Camera (Built-in)
    [AVFoundation input device @ 0x7fda1bc152c0] [1] Capture screen 0
    [AVFoundation input device @ 0x7fda1bc152c0] AVFoundation audio devices:
    [AVFoundation input device @ 0x7fda1bc152c0] [0] USB Audio CODEC
    [AVFoundation input device @ 0x7fda1bc152c0] [1] Built-in Microphone
    ```

    The device you're going to need is ":1" AVFoundation uses the convention
    "V:A" for "Video:Audio" so, if you want to capture video from your FaceTime
    camera the the audio from your Microphone, you would use "0:1". If you
    wanted just the audio only, you would use ":1" and leave the video out.


    RECORD THE AUDIO
    ==================================================

    ```
    $ ffmpeg -f avfoundation -i ":1" -t 10 audiocapture.mp3
    ```

    The above command will record 10 seconds of audio from the built in
    microphone and save it as `audiocapture.mp3`. You can set how long you want
    FFMPEG to record by changing the value for `-t`. If you want to record a
    full hour, set it to "3600".

    ```
    $ ffmpeg -f avfoundation -i ":1" -t 3600 audiocapture.mp3
    ```

    What the flags mean
    --------------------------------------------------

    -   `-f` = "force format". In this case we're forcing the use of AVFoundation
    -   `-i` = input source. Typically it's a file, but you can use devices.
        -   `"0:1"` = Record both audio and video from FaceTime camera and built-in mic
        -   `"0"` = Record just video from FaceTime camera
        -   `":1"` = Record just audio from built-in mic
    -   `-t` = time in seconds. If you want it to run indefinitely until you
               stop it (ControlC) omit this value (not recommended)

    Input Volume
    --------------------------------------------------

    Keep in mind that you're using the built-in microphone which isn't great to
    begin with. Ensure that you set the gain high enough (System Preferences,
    Sounds) so that the Mic can hear you. It would probably be best to get a
    quality USB microphone instead.

__DATA_SECTION__

#=== EDITOR SETTINGS ========================================================= {{{1
# vim: set et ts=4 :
