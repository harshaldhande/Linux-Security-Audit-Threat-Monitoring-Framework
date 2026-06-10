#!/bin/bash

# ============================
# Rootkit Detection Module
# ============================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

REPORT_DIR="../reports/rootkit_reports"
REPORT_FILE="$REPORT_DIR/rootkit_scan_$TIMESTAMP.txt"

mkdir -p "$REPORT_DIR"

clear

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}      ROOTKIT DETECTION MODULE${NC}"
echo -e "${CYAN}========================================${NC}"
echo -e "${BLUE}Date:${NC} $(date)"
echo

# Check if rkhunter exists
if ! command -v rkhunter &> /dev/null
then
    echo -e "${RED}[ERROR] rkhunter is not installed.${NC}"
    echo
    echo "Install using:"
    echo "sudo apt install rkhunter -y"
    exit 1
fi

echo -e "${YELLOW}[INFO] Starting Rootkit Scan...${NC}"
echo -e "${YELLOW}[INFO] Report will be saved to:${NC}"
echo "$REPORT_FILE"
echo

rkhunter --check --skip-keypress > "$REPORT_FILE" 2>&1

echo
echo -e "${GREEN}[SUCCESS] Rootkit scan completed.${NC}"
echo -e "${GREEN}[SUCCESS] Report saved at:${NC}"
echo "$REPORT_FILE"

echo
echo -e "${BLUE}Report Summary${NC}"
echo "----------------------------------------"

grep -i "Warning" "$REPORT_FILE" | tail -10

echo
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}      SCAN COMPLETED${NC}"
echo -e "${CYAN}========================================${NC}"
