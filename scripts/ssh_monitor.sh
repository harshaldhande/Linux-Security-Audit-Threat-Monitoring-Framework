#!/bin/bash

# ============================
# SSH Activity Monitor
# ============================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

clear

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}       SSH ACTIVITY MONITOR${NC}"
echo -e "${CYAN}========================================${NC}"
echo -e "${BLUE}Date:${NC} $(date)"
echo

# Statistics
SUCCESS_COUNT=$(journalctl -u ssh --no-pager | grep -c "Accepted password")
PUBKEY_COUNT=$(journalctl -u ssh --no-pager | grep -c "Accepted publickey")
FAILED_COUNT=$(journalctl -u ssh --no-pager | grep -c "Failed password")
INVALID_COUNT=$(journalctl -u ssh --no-pager | grep -c "Invalid user")

echo -e "${YELLOW}SSH Statistics${NC}"
echo "----------------------------------------"
echo -e "Successful Password Logins : ${GREEN}$SUCCESS_COUNT${NC}"
echo -e "Public Key Logins          : ${GREEN}$PUBKEY_COUNT${NC}"
echo -e "Failed Login Attempts      : ${RED}$FAILED_COUNT${NC}"
echo -e "Invalid User Attempts      : ${YELLOW}$INVALID_COUNT${NC}"
echo

echo -e "${BLUE}Recent SSH Events (Last 20)${NC}"
echo "----------------------------------------"
journalctl -u ssh --no-pager -n 20
echo

echo -e "${GREEN}Successful Password Logins${NC}"
echo "----------------------------------------"
journalctl -u ssh --no-pager | grep "Accepted password" || \
echo "No successful password logins found."
echo

echo -e "${GREEN}Successful Public Key Logins${NC}"
echo "----------------------------------------"
journalctl -u ssh --no-pager | grep "Accepted publickey" || \
echo "No public key logins found."
echo

echo -e "${RED}Failed Login Attempts${NC}"
echo "----------------------------------------"
journalctl -u ssh --no-pager | grep "Failed password" || \
echo "No failed login attempts found."
echo

echo -e "${YELLOW}Invalid User Attempts${NC}"
echo "----------------------------------------"
journalctl -u ssh --no-pager | grep "Invalid user" || \
echo "No invalid user attempts found."
echo

# Brute Force Detection
RECENT_FAILED=$(journalctl -u ssh --no-pager | grep "Failed password" | tail -100 | wc -l)

echo -e "${BLUE}Brute Force Detection${NC}"
echo "----------------------------------------"
echo "Recent Failed Attempts: $RECENT_FAILED"

if [ "$RECENT_FAILED" -gt 5 ]; then
    echo -e "${RED}[ALERT] Possible Brute Force Attack Detected!${NC}"
else
    echo -e "${GREEN}[OK] No Brute Force Activity Detected.${NC}"
fi

echo
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}     SSH MONITORING COMPLETED${NC}"
echo -e "${CYAN}========================================${NC}"
