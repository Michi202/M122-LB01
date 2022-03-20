. backup_config.conf
. backup_functions.sh
USER_HOMES=$(mktemp /tmp/backup_script_user_homes.XXXXXX)
EXCLUSIONS=$(mktemp /tmp/backup_script_exclusions.XXXXXX)
ARCHIVE_DATE=$(date '+%d-%m-%Y')
LOG_FILE="$BACKUP_FOLDER/$BACKUP_FILE_PREFIX$ARCHIVE_DATE.log"

touch $LOG_FILE

if [[ ! -d "$BACKUP_FOLDER" ]]; then    mkdir "$BACKUP_FOLDER"
fi

while IFS= read -r group || [ -n "$group" ]; do
    if groupExists $group; then
        group_exclusions=""
        if groupExclusionsExist $group; then
            log I $LOG_FILE "group exclusions found for $group"
            group_exclusions="${group}_exclusions.txt"
        else
            log I $LOG_FILE "group exclusions not found for $group"
        fi

        for user in $(members $group); do
            user_home=$(eval echo ~$user)
            if userHomeExists $user_home; then
                #only add the user home directory to the file if it doens't exist already
                grep -qxF $user_home $USER_HOMES || echo $user_home >> $USER_HOMES
                if [ "$group_exclusions" != "" ]; then
                    addExclusionsToFile $user_home $group_exclusions $EXCLUSIONS
                fi
            else
                log W $LOG_FILE "user home for user $user doesnt exist"
            fi
        done
    else
        log W $LOG_FILE "group $group doesn't exist"
    fi
done < $GROUPS_FILE

if tar --exclude-from $EXCLUSIONS -cf "$BACKUP_FOLDER/$BACKUP_FILE_PREFIX$ARCHIVE_DATE.tar" -T $USER_HOMES; then
    log I $LOG_FILE "backup tar archive successfully create in $BACKUP_FOLDER"
else
    log E $LOG_FILE "error while creating tar archive"
fi

rm "$USER_HOMES"
rm "$EXCLUSIONS"

find $BACKUP_FOLDER -mtime +$MAX_BACKUP_ARCHIVE_AGE -type f -delete