#!/bin/bash

function get_tty () {
    local vendor="${1}"
    local product="${2}"
    # return the tty{} value, eg; U2
    sysctl dev.uchcom | grep "vendor=${vendor} product=${product}" | sed -r 's/.*ttyname=([^\s]+) .*/\1/'
}


function create_symlink () {
    local source="${1}"
    # failsafe
    if [ "${source}" == 'tty' ]; then return; fi
    local target="/mnt/system/iocage/jails/smsrouter/root/dev/${2}"
    if [ -e "${target}" ]; then rm -f "${target}"; fi
    ln -s "${source}" "${target}"
}

# Sim800C
create_symlink "tty$(get_tty '0x1a86' '0x7523')" "ttySim800C"
