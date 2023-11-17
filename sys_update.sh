#=======================================================
# ╔═╗╔╗╔╗     ╔══╗╔╗ ╔╗
# ║╔╝╚╬╬╝╔═══╗║╔╗║║║ ║║
# ║║ ╔╬╬╗╚═══╝║╚╝║║╚═╝║
# ╚╝ ╚╝╚╝     ║╔═╝╚═╗╔╝
#             ║║  ╔═╝║ 
#             ╚╝  ╚══╝ 
#
#  Author: rx-py
#  Github: github.com/rx-py
#
#=======================================================

#!/bin/zsh

# Define log file
LOG_FILE=/var/log/custom/pacman-updates.log  # feel free to edit this location

# log errors explicitly
log_error() {
    local error_message="$1"
    echo "Error: $error_message" >> "$LOG_FILE"
}

# function to handle failures during update
handle_failure() {
    local command="$1"
    local error_message="$2"
    
    if [[ $? -ne 0 ]]; then
        log_error "Command '$command' failed: $error_message"
        echo "Error: Command '$command' failed. Check $LOG_FILE for details."
        # exit script if a command fails
        exit 1
    fi
}

# log command output to both terminal and log file
log_command() {
    local command="$1"
    echo "========================================="
    echo "$command"
    echo "========================================="
    if eval "$command" 2>&1 | tee -a "$LOG_FILE"; then
        echo "Command completed successfully."
    else
        echo "Error: Command failed. Check $LOG_FILE for details."
    fi
    echo
}

# pacman
run_pacman_refresh() {
    log_command "sudo pacman -Sy"
    sleep 1
}

run_check_updates() {
    log_command "pacman -Qu"
    sleep 5
}

run_check_conflicts() {
    log_command "pacman -Qqdt"
    sleep 3
}

run_pacman_updates() {
    log_command "sudo pacman -Su"
    sleep 3
}

# run package updates using yay
run_yay_updates() {
    log_command "yay -Syu --devel --noconfirm --needed"
    sleep 3
}

# oh-my-zsh updates
run_oh_my_zsh_updates() {
    log_command "zsh /usr/local/sbin/scriptx/omzupdate.sh"
    echo
}

# Main script
run_pacman_refresh
run_check_updates
run_check_conflicts
run_pacman_updates
run_yay_updates
run_oh_my_zsh_updates

echo "=================================="
echo "!!!! System updates completed !!!!"
echo "=================================="


