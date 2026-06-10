#!/bin/bash

# ============================
# Open Ports Audit Module
# ============================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

REPORT_DIR="../reports/open_ports_reports"
REPORT_FILE="$REPORT_DIR/open_ports_$TIMESTAMP.txt"

mkdir -p "$REPORT_DIR"

clear

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}         OPEN PORTS AUDIT${NC}"
echo -e "${CYAN}========================================${NC}"
echo -e "${BLUE}Date:${NC} $(date)"
echo -e "${BLUE}Hostname:${NC} $(hostname)"
echo

# Count listening ports
TCP_COUNT=$(ss -tln | tail -n +2 | wc -l)
UDP_COUNT=$(ss -uln | tail -n +2 | wc -l)

echo -e "${YELLOW}Port Statistics${NC}"
echo "----------------------------------------"
echo -e "Listening TCP Ports : ${GREEN}$TCP_COUNT${NC}"
echo -e "Listening UDP Ports : ${GREEN}$UDP_COUNT${NC}"
echo

echo -e "${BLUE}Listening Services${NC}"
echo "----------------------------------------"
ss -tulnp
echo

# Save report
{
    echo "========================================"
    echo "OPEN PORTS AUDIT REPORT"
    echo "========================================"
    echo "Date: $(date)"
    echo "Hostname: $(hostname)"
    echo

    echo "Listening TCP Ports: $TCP_COUNT"
    echo "Listening UDP Ports: $UDP_COUNT"
    echo

    ss -tulnp

} > "$REPORT_FILE"

echo -e "${GREEN}[SUCCESS] Report saved:${NC}"
echo "$REPORT_FILE"
echo

# Highlight common risky ports
echo -e "${YELLOW}Security Review${NC}"
echo "----------------------------------------"

ss -tulnp | grep -E ":21 |:23 |:25 |:3306 |:5432 " && \
echo -e "${RED}[WARNING] Sensitive services exposed.${NC}"

echo

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}      AUDIT COMPLETED${NC}"
echo -e "${CYAN}========================================${NC}"
