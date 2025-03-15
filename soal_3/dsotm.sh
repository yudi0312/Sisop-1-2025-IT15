#!/bin/bash
clear_screen() {
    clear
}
show_header() {
    echo -e "\033[1;35m"
    echo "   █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█"
    echo "   █░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░█"
    echo "   █░THE DARK SIDE OF THE MOON░█"
    echo "   █░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░█"
    echo "   ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
    echo -e "\033[0m"
}


speak_to_me() {
    declare -a history
    colors=(31 32 33 34 35 36 91 92 93 94 95 96)
    while true; do
        response=$(curl -s "https://www.affirmations.dev")
        affirmation=$(echo "$response" | awk -F'"' '/affirmation/{print $4}')
        if [ -n "$affirmation" ]; then
            history+=("$affirmation")
        fi

        clear_screen
        show_header

        echo -e "\n\033[1;35m╔════════════════════════════════════╗"
        echo -e "║     SPEAK TO ME - AFFIRMATIONS     ║"
        echo -e "╚════════════════════════════════════╝\033[0m"

        for ((i = 0; i < ${#history[@]}; i++)); do
            color_index=$((i % ${#colors[@]})) 
            echo -e "\033[1;${colors[color_index]}m◈ ${history[$i]}\033[0m"
        done

        echo -e "\n\033[1;37mPress Ctrl+C to return...\033[0m"
        sleep 1
    done
}

on_the_run() {
    local width=$(tput cols)
    local symbols=("▓")
    echo -e "\033[1;35mLoading ...\033[0m"
    for ((i=0; i<=100; i+=2)); do
        filled=$((width * i / 100))
        bar=$(printf "%${filled}s" | sed "s/ /${symbols[RANDOM%1]}/g")
        echo -ne "\r\033[1;32m${bar}\033[0m \033[1;37m$i%\033[0m"
        sleep 1
    done
    echo
}

time_clock() {
    while true; do
        clear_screen
        show_header
        echo -e "\n\033[1;33m╔════════════════════════════════════╗"
        echo -e "║                TIME                ║"
        echo -e "╚════════════════════════════════════╝\033[0m"
        date +"%Y-%m-%d | %H:%M:%S" | awk -F ' \\| ' '{
            printf "\n\033[1;32m%s \033[1;36m%s\033[0m\n", $1, $2
        }'
        
        sleep 1
    done
}

money_matrix() {
    local symbols=('$' '€' '£' '¥' '₿' '₹' '₣' '¢' '₩')
    local cols=$(tput cols)
    while true; do
        clear_screen
        for ((i=0; i<cols; i++)); do
            sym=${symbols[$RANDOM % ${#symbols[@]}]}
            echo -ne "\033[$((RANDOM % 10 + 2));${i}H\033[1;32m${sym}\033[0m"
        done
        sleep 0.1
    done
}

brain_damage() {
    while true; do
        clear
        show_header
        echo -e "\n\033[1;35m╔═════════════════════════════════════════════╗"
        echo -e "║                BRAIN DAMAGE                 ║"
        echo -e "╚═════════════════════════════════════════════╝\033[0m"

       echo "top - $(uptime)"
        total_tasks=$(ps -e --no-headers | wc -l)
        running=$(ps -eo stat | grep -c 'R')
        sleeping=$(ps -eo stat | grep -c 'S')
        echo "Tasks: $total_tasks total, $running running, $sleeping sleeping, 0 stopped, 0 zombie"
        
        cpu_data=$(top -bn1 | grep '%Cpu(s)')
        echo "$cpu_data" | awk '{
            printf "%%Cpu(s): %5.1f us, %5.1f sy, %5.1f ni, %5.1f id, %5.1f wa, %5.1f hi, %5.1f si, %5.1f st\n",
            $2, $4, $6, $8, $10, $12, $14, $16
        }'
        
        free -m | awk '/Mem:/ {printf "MiB Mem : %s total, %s free, %s used, %s buff/cache\n", $2, $4, $3, $6}'
        free -m | awk '/Swap:/ {printf "MiB Swap: %s total, %s free, %s used\n", $2, $4, $3}'
        
        echo ""
        echo "  PID USER    PR  NI  VIRT    RES S %CPU %MEM   TIME+ COMMAND"
        ps -eo pid,user,pri,ni,vsz,rss,stat,%cpu,%mem,time,comm --sort=-%cpu | 
        head -n 11 | 
        awk 'NR>1 {
            printf "%5d %-8s %2d %3d %6dM %5dM %1s %4.1f %4.1f %9s %s\n",
            $1, $2, $3, $4, $5/1024, $6/1024, $7, $8, $9, $10, $11
        }'
        
        sleep 1
    done
}

if [[ $1 == "--play="* ]]; then
    track="${1#*=}"
    track="${track//\"/}"
    clear_screen
    show_header
    case $track in
        "Speak to Me") speak_to_me ;;
        "On the Run") on_the_run ;;
        "Time") time_clock ;;
        "Money") money_matrix ;;
        "Brain Damage") brain_damage ;;
        *) 
            echo -e "\033[1;31mInvalid track!\033[0m"
            echo -e "\033[1;32mUse : ./dsotm.sh --play="[TRACK]"\033[0m"
            echo -e "Available tracks: Speak to Me, On the Run, Time, Money, Brain Damage"
            echo -e "\033[1;31mPLZ!!!! MATCH THE COMMAND TRACK FORMAT\033[0m"
            exit 1
            ;;
    esac
else
    echo -e "\033[1;31mUsage: ./dsotm.sh --play=\"<Track>\"\033[0m"
    echo -e "\033[1;34mAvailable tracks:\033[0m"
    echo -e "  \033[1;36mSpeak to Me\033[0m    - Word Affirmation"
    echo -e "  \033[1;32mOn the Run\033[0m     - Loading Bar"
    echo -e "  \033[1;33mTime\033[0m         - Live clock"
    echo -e "  \033[1;35mMoney\033[0m        - Matrix"
    echo -e "  \033[1;34mBrain Damage\033[0m - System monitor"
    exit 1
fi
