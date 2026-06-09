#!/bin/bash

echo "===== USERS ====="
cut -d: -f1 /etc/passwd

echo ""
echo "===== SUDO USERS ====="
getent group sudo
