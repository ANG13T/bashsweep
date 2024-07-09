![]()

# Bash Sweep
Tool for automating bash cleanup tasks with cron jobs

### Scripts
- Remove Empty Directories
- Remove Files Older than X Days
- Organize Files by Extension
- Remove Temporary Files
- Search Files for Keyword

### Cron Jobs
Once you select the clean up function for bashsweep, you will be prompted with a crontab request.

A crontab (aka "cron table") is a configuration file used in Unix-based operating systems to schedule and automate repetitive tasks.
You can view the cron table by using the command `crontab -l`

Cron jobs are independent background tasks within the cron table set to run at specific times or intervals.

#### Cron Job Structure 
```
* * * * * command_to_be_executed
- - - - -
| | | | |
| | | | +---- Day of the week (0 - 6) (0 = Sunday, 1 = Monday, ..., 6 = Saturday)
| | | +------ Month (1 - 12)
| | +-------- Day of the month (1 - 31)
| +---------- Hour (0 - 23)
+------------ Minute (0 - 59)
```

Example Cron Schedule for **Everyday at 1:30PM** 

``
30 13 * * * /path/to/your/script.sh
``

### Contributing
bashsweep is open to any contributions. Please fork the repository and make a pull request with the features or fixes you want to implement.

### Support
If you enjoyed skytrack, please consider [becoming a sponsor](https://github.com/sponsors/ANG13T) or donating on [buymeacoffee](https://www.buymeacoffee.com/angelinatsuboi) in order to fund my future projects.

To check out my other works, visit my [GitHub profile](https://github.com/ANG13T).