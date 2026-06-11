#!/bin/bash

echo "===== FIREWALL AUDIT ====="
echo ""

echo "[1] UFW Service Status:"
sudo systemctl is-active ufw
sudo systemctl is-enabled ufw
echo ""

echo "[2] UFW Firewall Status:"
sudo ufw status verbose
echo ""

echo "===== END OF FIREWALL AUDIT ====="
