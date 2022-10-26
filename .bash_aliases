# ESP IDF
if [ -z "$IDF_PATH" ]; then
    export IDF_PATH=$HOME/esp/esp-idf
fi
alias idf="idf.py"

alias idf-setup=". $IDF_PATH/export.sh"
alias idf-appflash="idf.py -b 2000000 encrypted-app-flash monitor"
alias idf-monitor="idf.py -b 2000000 monitor -E"
alias idf-build="idf.py build"

alias idf-unencrypted-appflash="idf.py -b 2000000 app-flash monitor"
alias idf-unencrypted-monitor="idf.py -b 2000000 monitor"

idf-monitor-and-log() {
    # if $1 is empty, use default log file name
    if [ -z "$1" ]; then
        log_file="./idf-monitor.log"
    else
        log_file="$1"
    fi
    idf-monitor 2>&1 | tee -a $log_file
}

# docker
alias dc=docker-compose

# git
alias git-exclude="git update-index --assume-unchanged"
alias git-include="git update-index --no-assume-unchanged"

# ubuntu
alias ubuntu-update="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && sudo snap refresh"

# clipboard (usage: echo "hello world" | clip)
alias clip="xclip -selection c"

# exa
alias lls="exa --icons --group-directories-first"

# if .bash_aliases_work is not empty, source it
if [ -f ~/.bash_aliases_work ]; then
    source ~/.bash_aliases_work
fi
