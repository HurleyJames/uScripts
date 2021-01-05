#!/bin/bash

function logStart() { echo -e "${BLUE_BOLD}>> start: ${BLUE}${1}${RESET}"; }
function logInfo() { echo -e "${CYAN_BOLD}>> info:  ${CYAN}${1}${RESET}"; }
function logWarn() { echo -e "${YELLOW_BOLD}>> warn:  ${YELLOW}${1}${RESET}"; }
function logError() { echo -e "${RED_BOLD}>> error: ${RED}${1}${RESET}"; }
function logOk() { echo -e "${GREEN_BOLD}>> ok:    ${GREEN}${1}${RESET}"; }
function logBlank() { echo ''; }

# 颜色
function isColorful() {
	test -t 1 || return 1; # if it is not a terminal
	local CM="$(tput colors)";
	[[ -n "$CM" ]] && [[ "$CM" -ge 8 ]] && return 0;
	return 1;
}
if isColorful; then
	BOLD="\x1b[1m";      DIM="\x1b[2m";           RESET="\x1b[0m";
	RED="\x1b[0;31m";    RED_BOLD="\x1b[1;31m";
	YELLOW="\x1b[0;33m"; YELLOW_BOLD="\x1b[1;33m";
	GREEN="\x1b[0;32m";  GREEN_BOLD="\x1b[1;32m";
	BLUE="\x1b[0;34m";   BLUE_BOLD="\x1b[1;34m";
	CYAN="\x1b[0;36m";   CYAN_BOLD="\x1b[1;36m";
fi

function isYes() { [[ "$1" == y* ]] || [[ "$1" == Y* ]]; }
function isNo() { [[ "$1" == n* ]] || [[ "$1" == N* ]]; }
function beginAsk() { echo -e "\n${BLUE_BOLD}>> ${BLUE}${1}"; }
function endAsk() { printf "${RESET}"; }
function beginDim() { printf "${DIM}"; }
function endDim() { printf "${RESET}"; }
function fatal() { logError "$1"; exit 1; }
function userCancel() {
	echo -e "${RESET}\n${YELLOW_BOLD}>> exit:  ${YELLOW}cancel by user${RESET}";
	exit 0;
}

# 问题 | 选择
function confirm() {
	if isYes "$2"; then return 0; fi
	if isNo "$2"; then return 1; fi
	
	local yn;
	beginAsk "$1";
	while read -p "Confirm (y/n) > " yn; do
		if isYes "$yn"; then endAsk; return 0; fi
		if isNo "$yn"; then endAsk; return 1; fi
	done
}