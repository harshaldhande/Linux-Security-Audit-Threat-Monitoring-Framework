#!/bin/bash

# ============================
# Sudo Activity Monitor
# ============================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

clear

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}       SUDO ACTIVITY MONITOR${NC}"
echo -e "${CYAN}========================================${NC}"
echo -e "${BLUE}Date:${NC} $(date)"
echo

# Total sudo commands
SUDO_COUNT=$(journalctl --no-pager | grep -c "sudo")

echo -e "${YELLOW}Privilege Escalation Statistics${NC}"
echo "----------------------------------------"
echo -e "Total Sudo Events : ${GREEN}$SUDO_COUNT${NC}"
echo

echo -e "${BLUE}Recent Sudo Activity (Last 20 Events)${NC}"
echo "----------------------------------------"
journalctl --no-pager | grep "sudo" | tail -20
echo

echo -e "${GREEN}Executed Sudo Commands${NC}"
echo "----------------------------------------"
journalctl --no-pager | grep "COMMAND="
echo

echo -e "${YELLOW}Users Performing Sudo Operations${NC}"
echo "----------------------------------------"
journalctl --no-pager | grep "sudo" | awk '{print $5}' | sort | uniq
echo

echo -e "${BLUE}Recent Root Access Events${NC}"
echo "----------------------------------------"
journalctl --no-pager | grep "session opened for user root" | tail -10
echo

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}    SUDO MONITORING COMPLETED${NC}"
echo -e "${CYAN}========================================${NC}"
