#!/bin/bash

# called by dracut
check() {
    require_binaries kpartx || return 1
    local root=/dev/block/$(find_root_block_device)
    [[ $hostonly ]] && ! (lsblk -sno TYPE $root | grep -q crypt) && return 255
    return 0
}

# called by dracut
cmdline() {
    local root uuid
    root=/dev/block/$(find_root_block_device)
    for uuid in "$(lsblk -sno TYPE,PTUUID $root | grep crypt \
        | cut -d ' ' -f 2)"; do
        [[ -n "$uuid" ]] && printf " rd.kpartx.uuid=%s" "$uuid"
    done
}

# called by dracut
install() {
    inst $(find_binary kpartx)
    inst_hook cmdline 31 "$moddir/parse-kpartx.sh"
}
