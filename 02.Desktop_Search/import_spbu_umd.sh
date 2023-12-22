#!/bin/bash

dl_spbu_s_e () {
    curl "$1" -s --compressed -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/118.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' -H 'Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3' -H 'Accept-Encoding: gzip, deflate, br' -H 'DNT: 1' -H 'Connection: keep-alive'
}

dl_spbu_oop () {
    if [[ "$2" == true ]];
    then
        dl_spbu_s_e "$1" | grep -o -E "'https://nc\.spbu\.ru/.+?'" | sed "s/'//g" | sort | uniq | sort -R | head -n 10
    else
        dl_spbu_s_e "$1" | grep -o -E "'https://nc\.spbu\.ru/.+?'" | sed "s/'//g" | sort | uniq
    fi
}

usage() {
    echo "./import_spbu_umd.sh [-s | --source] <url> [-d | --destination] <folder> [-p | --probe]";
    echo "[-s | --source] - from download"
    echo "[-d | --destination] - to what path download"
    echo "[-p | --probe] - random 10 files"
    echo "source and destination parameters is required";
    exit 1;
}

SOURCE=""
DESTINATION=""
PROBE=false

for arg in "$@"; do
    shift
    case "$arg" in
        '--source')   set -- "$@" '-s' ;;
        '--destination') set -- "$@" '-d' ;;
        '--probe')   set -- "$@" '-p' ;;
        *)          set -- "$@" "$arg" ;;
    esac
done

for arg in "$@"; do
    echo "$arg"
done

while getopts ":s:d:p" arg
do
    case "$arg" in
        's') SOURCE=${OPTARG} ;;
        'd') DESTINATION=${OPTARG} ;;
        'p') PROBE=true;;
        ':') usage ;;
        '*') usage ;;
    esac
done

echo "SOURCE = $SOURCE"
echo "DESTINATION = $DESTINATION"
echo "PROBE = $PROBE"

if [ -z "$SOURCE"  ] ; then
    echo "Source info should be filled!"
    usage
fi

if [ -z "$DESTINATION"  ] ; then
    echo "Destination info should be filled!"
    usage
fi

if [ -n "$DESTINATION" ]; then
    mkdir -p "$DESTINATION"
fi

function download {
    if ! wget -O "$2" "$1/download"; then
       >&2 echo "Cannot download $1"
       return 15
    fi
}

LOAD="$(dl_spbu_oop "$SOURCE" "$PROBE")"

echo "LOAD = $LOAD"

FILENAME=""
FILEPATH=""

for u in $LOAD; do
    FILENAME="${u//[^a-zA-Z0-9]/-}"
    FILEPATH="$DESTINATION/$FILENAME.rar"
    download "$u" "$FILEPATH"
    echo $?
done

function unpack {
    for file in "$DESTINATION"/*;
    do
        if [ -f "$file" ];
        then
            unrar e "$file" -o "$DESTINATION"
        fi
    done
}

recoll_index () {
    mkdir -p .recoll
    echo "topdirs = $(realpath "$DESTINATION")" > ./.recoll/recoll.conf
    echo "start recollindex"
    recollindex -c ./.recoll
}

unpack
recoll_index