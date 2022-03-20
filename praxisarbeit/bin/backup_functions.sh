. backup_config.conf

log(){
  DATE=`date '+%Y.%m.%d %H:%M:%S'`
  LEVEL=$1
  shift
  case $LEVEL in
    D)
      case $LOGLEVEL in
        D)
        echo "$DATE:DEBUG:$*\n" >> $1
        ;;
      esac
      ;;
    I)
      case $LOGLEVEL in
        D|I)
        echo "$DATE:INFO:$*\n" >> $1
        ;;
      esac
      ;;
    W)
      case $LOGLEVEL in
        D|I|W)
        echo "$DATE:WARNING:$*\n" >> $1
        ;;
      esac
      ;;
    E)
      echo "$DATE:ERROR:$*\n" >> $1
      ;;
    *)
      echo "$DATE:UNKNOWN:$*\n" >> $1
      ;;
    esac
}

function groupExists() {
  if [[ $(getent group $1) ]]; then
      true
  else
      false
  fi
}

function groupExclusionsExist() {
  if [[ -f "${1}_exclusions.txt" ]]; then
      true
  else
      false
  fi
}

function userHomeExists() {
    if [[ -d "${1}" ]]; then
        true
    else
        false
    fi
}

function addExclusionsToFile() {
  user_home=$1
  group_exclusions=$2
  all_exclusions=$3

  while IFS= read -r exclusion || [ -n "$exclusion" ]; do
    full_exclusion="$user_home$exclusion"
    #add full exclusion to all exclusion file if it hasn't been added yet
    grep -qxF $full_exclusion $all_exclusions || echo $full_exclusion >> $all_exclusions
  done < $group_exclusions

}