#!/bin/bash

SALT="T3rr4Bl@d3!"

main_menu() {
    while true; do
        clear
        echo "=================================="
        echo "           MAIN TERMINAL"
        echo "=================================="
        echo "1) Register New Account"
        echo "2) Login to Existing Account"
        echo "3) Exit Main Terminal"
        echo "=================================="
        read -p "Enter option [1-3]: " option </dev/tty

        case $option in
            1) ./register.sh ;;
            2) login ;;
            3) echo "Goodbye!"; exit 0 ;;
            *) echo "Invalid option. Please try again."; sleep 1 ;;
        esac
    done
}

login() {
    clear
    echo "=================================="
    echo "             Login"
    echo "=================================="
    read -p "Enter your email: " email
    read -sp "Enter your password: " password
    echo ""

    if awk -F, -v e="$email" '$1 == e {print $1, $2, $3}' data/player.csv | while read user_email user_name hashed_pass; do
        input_hashed=$(echo -n "$password$SALT" | sha256sum | awk '{print $1}')

        if [[ "$input_hashed" == "$hashed_pass" ]]; then
            echo "Login successful! Welcome, $user_name."
            sleep 1
            player_menu
            return
        fi
    done; then
        echo "Login failed. Invalid email or password."
        sleep 1
    fi
}

player_menu() {
    while true; do
        clear
        echo "=================================="
        echo "          PLAYER MENU"
        echo "=================================="
        echo "1) Crontab Manager"
        echo "2) Exit Player Menu"
        echo "=================================="
        read -r -p "Choose an option: " option </dev/tty
        case $option in
            1) ./scripts/manager.sh ;;
            2) main_menu; return ;; 
            *) echo "Invalid option. Please try again."; sleep 1 ;;
        esac
    done
}

main_menu
