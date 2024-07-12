##0######################################################################
# BASH SWEEP (v.0.1r0)
# Tool for automating bash cleanup tasks with cron jobs
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
    "Share File"
    "Exit"
)

# Script paths
paths=(
    scripts/remove_empty_dir.sh
    scripts/outdated_file_deletion.sh
    scripts/organize_files_by_extension.sh
    scripts/temp_delete.sh
    scripts/search_files.sh
    scripts/share_file.sh
)

# Cron Schedule
CRON_SCHEDULE=""
export CRON_SCHEDULE

echo "=============================================================="
echo "BASH SWEEP (v.0.1r0)"
echo "Tool for automating bash cleanup tasks with cron jobs"
echo "By G4LXY (Angelina Tsuboi: angelinatsuboi.com)"
echo "github.com/ANG13T/bashsweep"
echo "=============================================================="

generate_path() {
    local script_path="$1"
    DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    echo "$DIR/$script_path"
}

# Functios for configuring cron schedule
config_crontab() {
    local script_path="$1"

    read -p "Do you want to configure a crontab? (Y/N): " config_crontab
    case $config_crontab in
        [yY])
            read -p "Do you have a cron schedule? (Y/N): " cron_choice
            case $cron_choice in
                [yY])
                    CRON_SCHEDULE=$(ask_for_cron_schedule)
                    export CRON_SCHEDULE
                    show_cron_details "$CRON_SCHEDULE" "$script_path"
                    echo "$CRON_SCHEDULE $script_path"
                    (crontab -l; echo "$CRON_SCHEDULE $script_path") | crontab -
                ;;
                [nN])
                    CRON_SCHEDULE=$(ask_cron_form)
                    export CRON_SCHEDULE
                    show_cron_details "$CRON_SCHEDULE" "$script_path"
                    echo "$CRON_SCHEDULE $script_path"
                    (crontab -l; echo "$CRON_SCHEDULE $script_path") | crontab -
                ;;
                *)
                    echo "Invalid choice, exiting."
                    return 1
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
   if echo "$cron_schedule" | grep -Eq '^([0-5]?[0-9]|\*)([ \t]+([01]?[0-9]|2[0-3]|\*)([ \t]+([01]?[0-9]|3[01]|\*)([ \t]+([1-9]|1[0-2]|\*)([ \t]+([0-6]|\*))))$';  then
        print "Invalid cron schedule format. Please enter a valid cron expression."
        ask_for_cron_schedule
    fi
    echo "$cron_schedule"
}

ask_cron_form() {
    read -p "Minute (0-59): " minute
    read -p "Hour (0-23): " hour
    read -p "Day of month (1-31): " day_month
    read -p "Month (1-12): " month
    read -p "Day of week (0-6 with 0=Sunday): " day_week
    cron_schedule="$minute $hour $day_month $month $day_week"
    echo "$cron_schedule"
}

# Show cron job details
show_cron_details() {
    local cron_schedule="$1"
    local script_path="$2"

    echo "=============================================================="
    echo "Cron job details:"
    echo "Schedule: $cron_schedule"
    echo "Script path: $script_path"
    echo "Use crontab -l to view cron jobs"
    echo "=============================================================="
}

# Ask for the clean up function
PS3="Enter your choice: "
select opt in "${options[@]}"; do
    selected_option="$opt"
    case $REPLY in
        1)
            read -rp "Enter the directory path to clean (default: $HOME): " DIR_PATH
            chmod +x ./scripts/remove_empty_dir.sh
            ./scripts/remove_empty_dir.sh "$DIR_PATH"
            input="$(generate_path)${paths[0]} $DIR_PATH"
            config_crontab "${input}"
            ;;
        2)
            read -rp "Enter the directory to perform operation (default: $HOME): " DIR_PATH
            read -rp "Enter the number of days: " DAYS
            chmod +x ./scripts/outdated_file_deletion.sh
            ./scripts/outdated_file_deletion.sh "$DIR_PATH" "$DAYS"
            input="$(generate_path)${paths[1]} $DIR_PATH $DAYS"
            config_crontab "${input}"
            ;;

        3)
            read -rp "Enter the directory path to organize (default: $HOME): " DIR_PATH
            chmod +x ./scripts/organize_files_by_extension.sh
            ./scripts/organize_files_by_extension.sh "$DIR_PATH"
            input="$(generate_path)${paths[2]} $DIR_PATH"
            config_crontab "${input}"
            ;;

        4)
            read -rp "Enter the directory path to clean (default: $HOME): " DIR_PATH
            chmod +x ./scripts/temp_delete.sh
            ./scripts/temp_delete.sh "$DIR_PATH"
            input="$(generate_path)${paths[3]} $DIR_PATH"
            config_crontab "${input}"
            ;;
        5)
            read -rp "Enter the directory path to organize (default: $HOME): " DIR_PATH
            read -rp "Enter the keyword to search: " SEARCH_STRING
            chmod +x ./scripts/search_files.sh
            ./scripts/search_files.sh "$DIR_PATH" "$SEARCH_STRING"
             input="$(generate_path)${paths[4]} $DIR_PATH $SEARCH_STRING"
            config_crontab "${input}"
            ;;
        6) 	chmod +x ./scripts/share_file.sh
		./scripts/share_file.sh
	    ;;
	7)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid Option"
            ;;
    esac
done
