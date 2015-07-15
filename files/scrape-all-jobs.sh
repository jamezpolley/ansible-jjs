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

        cd $DESTDIR
        (
            echo "<html><head><title>Stable Job Reports</head></title>"
            echo "<body>"
            for report_html in *.html; do
                report=${report_html%%.html}
                echo "<p><a href=${report_html}>${report}</a></p>"
            done
            echo "</body></html>"
        ) > index.html
    fi

) 200> $CONFDIR/scrape-all-jobs.lock

