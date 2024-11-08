#!/usr/bin/bash

### COLORS VARS ###
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESET_CLR="\e[0m"

### FUNCTIONS ###
check_cmd() {
    if [[ $? -eq 0 ]]; then
        echo -e "[${GREEN} OK ${RESET_CLR}]"
    else
        echo -e "[${RED} ERROR ${RESET_CLR}]"
        exit 1
    fi
}

### START OF SCRIPT ###

### TEST ROOT ###
if [ "$(whoami)" != "root" ]; then
    echo -e "[${RED} ERROR ${RESET_CLR}] Unauthorized user. Please restart the script as root."
    exit 1
fi

### APACHE ###
if ! systemctl is-active -q httpd; then
    echo "Apache is already off."
else
    echo -n "Turn off Apache... "
    sudo systemctl stop httpd >/dev/null 2>&1
    check_cmd
fi

### MARIADB ###
if ! systemctl is-active -q mariadb; then
    echo "MariaDB is already off."
else
    echo -n "Turn off MariaDB... "
    sudo systemctl stop mariadb >/dev/null 2>&1
    check_cmd
fi

### SYMFONY ###
echo "Turn off Symfony..."
symfony server:stop

exit 0

### END OF SCRIPT ###
