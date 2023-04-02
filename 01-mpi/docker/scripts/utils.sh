#!/bin/bash

#########################################################################################
# UTILITES
#----------------------------------------------------------------------------------------

# determining if tput is installed, and then setting colors
which tput 2>&1 > /dev/null
if [[ $? -eq "0" ]]; then 
    _COLOR_NC="$(tput sgr0)"
    _COLOR_RED="$(tput setaf 1)"
    _COLOR_GREEN="$(tput setaf 2)"
    _COLOR_YELLOW="$(tput setaf 3)"
    _COLOR_BLUE="$(tput setaf 4)"
fi

function echo_info {
# @brief: print message to stderr with INFO prefix
    echo -e "[${_COLOR_GREEN}INFO${_COLOR_NC}]" "$@" >&2
}

function echo_erro {
# @brief: print message to stderr with ERRO prefix
    echo -e "[${_COLOR_RED}ERRO${_COLOR_NC}]" "$@" >&2
}

function echo_warn {
# @brief: print message to stderr with WARN prefix
    echo -e "[${_COLOR_YELLOW}WARN${_COLOR_NC}]" "$@" >&2
}

function echo_extra {
# @brief: print message to stderr with EXTR prefix
    echo -e "[${_COLOR_BLUE}EXTR${_COLOR_NC}]" "$@" >&2
}
