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


# Ask for the clean up function
PS3="Enter your choice: "
select opt in "${options[@]}"; do
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

    # STEP 2. Configuration of crontab (optional)
    echo "complete"
    esac
done

