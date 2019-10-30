#!/bin/sh

command -v getarg >/dev/null || . /lib/dracut-lib.sh

if ! getargbool 1 rd.kpartx -d -n rd_NO_KPARTX; then
    info "rd.kpartx=0: removing kpartx update"
    rm -f -- /etc/udev/rules.d/71-kpartx.rules
else
    KPARTX=$(getargs rd.kpartx.uuid -d rd_KPARTX_UUID)

    if [ -n "$KPARTX" ]; then
        for kpartxid in $KPARTX; do
            echo "SUBSYSTEM==\"block\", ACTION==\"add|change\", ENV{ID_PART_TABLE_UUID}==\"${kpartxid}\", RUN+=\"/sbin/kpartx -u \$env{DEVNAME}\"" >> /etc/udev/rules.d/71-kpartx.rules
        done
    fi
fi
