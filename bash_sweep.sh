########################################################################
# BASH SWEEP (v.0.1r0)
# Tool for running automated bash clean up commands via crontab
# By G4LXY (Angelina Tsuboi: angelinatsuboi.com)
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

# Script paths
paths=(
    ./scripts/remove_empty_dir.sh
    ./scripts/outdated_file_deletion.sh
    ./scripts/organize_files_by_extension.sh
    ./scripts/temp_delete.sh
    ./scripts/search_files.sh
)

echo "=============================================================="
echo "BASH SWEEP (v.0.1r0)"
echo "Tool for running automated bash clean up commands via crontab"
echo "By G4LXY (Angelina Tsuboi) angelinatsuboi.com"
echo "github.com/ANG13T/bashsweep"
echo "=============================================================="


# Functios for configuring cron schedule
config_crontab() {
    local script_path="$1"

    read -p "Do you want to configure a crontab? (Y/N): " config_crontab
    case $config_crontab in
        [yY])
            read -p "Do you have a cron schedule? (Y/N): " cron_choice
            case $config_crontab in
                [yY])
                    schedule=$(ask_for_cron_schedule)
                    show_cron_details "$schedule" "$script_path"
                ;;
                *)
                    schedule=$(ask_cron_form)
                    show_cron_details "$schedule" "$script_path"
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
    case $REPLY in
        1)  # Prompt user for directory path
            read -rp "Enter the directory path to clean (default: $HOME): " DIR_PATH
            DIR=${DIR_PATH:-"$HOME"}

            chmod +x ./scripts/remove_empty_dir.sh
            ./remove_empty_dir "$DIR"
            config_crontab "${paths[selected_option]}"
            ;;
        2)
            read -rp "Enter the directory to perform operation (default: $HOME): " DIR_PATH
            DIR=${DIR_PATH:-"$HOME"}

            read -rp "Enter the number of days (default: 30): " DAYS_INPUT
            # Use default value if no input is given
            DAYS=${DAYS_INPUT:-30}

            chmod +x ./scripts/outdated_file_deletion.sh
            ./outdated_file_deletion "$DIR" "$DAYS"
            config_crontab "${paths[selected_option]}"
            ;;

        3)  # Prompt user for directory path
            read -rp "Enter the directory path to organize (default: $HOME): " DIR_PATH

            DIR=${DIR_PATH:-"$HOME"}

            chmod +x ./scripts/outdated_file_deletion.sh
            ./outdated_file_deletion "$DIR"
            config_crontab "${paths[selected_option]}"
            ;;

        4) # Prompt user for directory path
            read -rp "Enter the directory path to clean (default: $HOME): " DIR_PATH

            ./temp_delete "$DIR_PATH"
            ;;
        5) # Prompt user for directory path
            read -rp "Enter the directory path to organize (default: $HOME): " DIR_PATH

            read -rp "Enter the keyword to search: " SEARCH_STRING

            ./search_files DIR_PATH SEARCH_STRING
            ;;
        6)
            echo "Exiting."
            break
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
done

