#!/bin/bash

set -eux

VENVDIR=$1
CONFDIR=$2
OUTPUTDIR=${3:-}
DESTDIR=${4:-}

set +u
source $VENVDIR/bin/activate
set -u

(
    flock --exclusive --nonblock 200 || exit 1

    for conffile in $CONFDIR/*.ini; do
        scrape_jobs --config-file $conffile --fetch
    done

    if [ ! -z "$DESTDIR" ]; then
        for file in $OUTPUTDIR/*.html; do
            cp $file $DESTDIR
        done
    fi
) 200> $CONFDIR/scrape-all-jobs.lock

