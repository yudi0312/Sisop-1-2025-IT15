add_cron_job() {
    local script_path=$1
    local job_desc=$2
    local log_file

    if [[ "$script_path" == *"core_monitor.sh" ]]; then
        log_file="$(pwd)/logs/core.log"
    elif [[ "$script_path" == *"frag_monitor.sh" ]]; then
        log_file="$(pwd)/logs/fragment.log"
    else
        echo "Error: Unknown script path!"
        return 1
    fi

    local cron_job="* * * * * $script_path>>$log_file"
    sudo systemctl restart cron

    if crontab -l 2>/dev/null | grep -q "$script_path"; then
        echo "$job_desc already scheduled!"
        return
    fi

    (crontab -l 2>/dev/null; echo "$cron_job") | crontab -
    echo "$job_desc scheduled successfully!"
}

remove_cron_job() {
    local script_path=$1
    local job_desc=$2

    if crontab -l 2>/dev/null | grep -q "$script_path"; then
        crontab -l 2>/dev/null | grep -v "$script_path" | crontab -
        echo "$job_desc removed successfully!"
    else
        echo "$job_desc is not currently scheduled."
    fi
}

view_cron_jobs() {
    echo "==================="
    echo "Active Cron Jobs:"
    echo "==================="
    crontab -l 2>/dev/null || echo "No active cron jobs."
    echo "==================="
}

echo "===================="
echo "  Crontab Manager"
echo "===================="
echo "1) Add CPU [Core] Usage Monitoring"
echo "2) Remove CPU [Core] Usage Monitoring"
echo "3) Add RAM [Fragment] Usage Monitoring"
echo "4) Remove RAM [Fragment] Usage Monitoring"
echo "5) View Active Jobs"
echo "6) Exit"
echo "===================="
read -p "Enter your choice: " choice </dev/tty

case $choice in
    1) add_cron_job "$(pwd)/scripts/core_monitor.sh" "CPU Monitoring" ;;
    2) remove_cron_job "$(pwd)/scripts/core_monitor.sh" "CPU Monitoring" ;;
    3) add_cron_job "$(pwd)/scripts/frag_monitor.sh" "RAM Monitoring" ;;
    4) remove_cron_job "$(pwd)/scripts/frag_monitor.sh" "RAM Monitoring" ;;
    5) view_cron_jobs; read -p "Press Enter to continue..." ;;
    6) exit 0 ;;
    *) echo "Invalid choice. Please try again."; sleep 1 ;;
esac