#!/bin/bash

DATE=$(date +%F)

sudo lynis audit system > reports/lynis_$DATE.txt
