# Bash Backup Script

This is a Bash script for performing backups of MySQL databases using Docker. The script creates backups of the specified databases and compresses the files into a backup directory.

## Requirements

- Docker
- MySQL/MariaDB
- Read access to the databases you want to backup
- Write permissions to the specified backup directory

## Configuration

Before running the script, you need to make the following configurations:

1. Set the MariaDB container name in the `CONTAINER_NAME` variable.
2. Specify the base directory to store the backups in the `dir_base` variable.
3. Set the database access credentials in the `MUSER` and `MSENHA` variables.
4. Add the names of the databases you want to backup to the `DB` array.
5. Configure the desired actions for handling the backup success or failure using the provided code snippets.

## Usage

1. Save the script to a file with the `.sh` extension.
2. Give execute permission to the script: `chmod +x script.sh`.
3. Run the script: `./script.sh`.

## Security Notice

Make sure to properly secure access to the script and the sensitive information contained within it, especially the database access credentials.

