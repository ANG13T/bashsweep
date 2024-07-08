########################################################################
# BASH SWEEP (v.0.1r0)
# Tool for running automated bash clean up commands via crontab
# By G4LXY (Angelina Tsuboi) angelinatsuboi.com
# github.com/ANG13T/bashsweep
#########################################################################

# Menu options

options=(
    "Remove Empty Directories"
    "Remove Files Older than X Days"
    "Organize Files by Extension"
    "Remove Temporary Files"
    "Search Files for Keyword"
    "Exit"
)

echo "=============================================================="
echo "BASH SWEEP (v.0.1r0)"
echo "Tool for running automated bash clean up commands via crontab"
echo "By G4LXY (Angelina Tsuboi) angelinatsuboi.com"
echo "github.com/ANG13T/bashsweep"
echo "=============================================================="


# Functios for configuring cron schedule
config_crontab() {
    read -p "Do you want to configure a crontab? (Y/N): " config_crontab
    case $config_crontab in
        [yY])
            read -p "Do you have a cron schedule? (Y/N): " cron_choice
            case $config_crontab in
                [yY])
                    ask_for_cron_schedule
                ;;
                *)
                    ask_cron_form
                ;;
            esac
        ;;

        *)
            break
        ;;
    esac
}

ask_for_cron_schedule() {
    read -p "Enter the cron schedule (e.g., '0 2 * * *' for daily at 2 AM): " cron_schedule
    # Validate cron schedule format
    if [[ ! $cron_schedule =~ ^[0-9*\/,-]+$ ]]; then
        echo "Invalid cron schedule format. Please enter a valid cron expression."
        ask_for_cron_schedule
    fi
    echo cron_schedule
}

ask_cron_form() {
    echo "Enter cron details..."
    read -p "Minute (0-59): " minute
    read -p "Hour (0-23): " hour
    read -p "Day of month (1-31): " day_month
    read -p "Month (1-12): " month
    read -p "Day of week (0-6 with 0=Sunday): " day_week
    cron_schedule="$minute $hour $day_month $month $day_week"
    echo cron_schedule
}

# Show cron job details
show_cron_details() {
    local cron_schedule="$1"
    local script_path="$2"

    echo "=============================================================="
    echo "Cron job details:"
    echo "Schedule: $cron_schedule"
    echo "Script path: $script_path"
    echo "=============================================================="
}

# Ask for the clean up function
PS3="Enter your choice: "
select opt in "${options[@]}"; do
    selected_option=$REPLY
    case "$REPLY" in
        1)
            chmod +x ./scripts/remove_empty_dir.sh
            ./scripts/remove_empty_dir.sh
            break
            ;;
        2)
            chmod +x ./scripts/outdated_file_deletion.sh
            ./outdated_file_deletion.sh
            break
            ;;
        3)
            chmod +x ./scripts/organize_files_by_extension.sh
            ./organize_files_by_extension
            break
            ;;
        4)
            chmod +x ./scripts/temp_delete.sh
            ./temp_delete
            break
            ;;
        5)
            chmod +x ./scripts/search_files.sh
            ./search_files
            break
            ;;
        6)
            echo "Exiting."
            break
            ;;
        *)
            echo "Invalid Option"
            break
            ;;
    esac

    # STEP 2. Configuration of crontab (optional)
    config_crontab
done

