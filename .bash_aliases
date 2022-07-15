# iot-module-fw project
alias cd-iot-module-fw='cd ~/Documents/GitHub/iot-module-fw'

# bsb-iot project
alias cd-bsb-iot='cd ~/Documents/GitHub/bsb-iot'

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

idf-build-config() {
    idf.py -DSDKCONFIG_DEFAULTS="sdkconfig.defaults;configs/sdkconfig.$1" build
}

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