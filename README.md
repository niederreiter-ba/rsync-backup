# Rsync Backup

## Usage example for Backup of OneNote backup files to a different location

1. Run `schtasks /create /tn "Run OneNote Backup" /tr "wsl /home/user/Documents/tools/onenote-backup/onenote-backup.sh" /sc minute` (change "minute" to a different time span to run it less often).
2. In Windows Task Scheduler, at the "General" tab in task properties, click "Run whether user is logged on or not", "Do not store password", "Hidden".
