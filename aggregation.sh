#!/bin/bash
# Агрегирование файлов по расширениям

WORKDIR="./.."
mkdir -p $WORKDIR/logs && touch "$WORKDIR"/logs/log.txt
LOGFILE="$WORKDIR"/logs/log.txt

ERRORTYPE="error"
INFOTYPE="info"

function getFiles {
    result=$(ls "$WORKDIR" | grep "[.]")
    
    if [ -z "$result" ]; then
        log "asdas" "Empty directory" && return 1
    fi

    echo "$result" && return 0
}

function log {
    case $1 in
        "$ERRORTYPE") 
            echo -e "$2 {$(date)};" >> "$LOGFILE" && return 0;; 
        "$INFOTYPE") 
            echo -e "$2 was moved to $3 dir {$(date)};" >> "$LOGFILE" && return 0;;
        *) 
            echo -e "unknown type - $1 {$(date)};" >> "$LOGFILE" && return 1;;
    esac
}



files=$( getFiles)

for file in $files
do 
    ext=$WORKDIR/$(awk -F. '{print $NF}' <<< "$file")
    mkdir -p "$ext"
    mv "$WORKDIR/$file" "$ext" && log "$INFOTYPE" "$file" "$ext"
done