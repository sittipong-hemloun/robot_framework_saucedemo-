#!/bin/bash
# Usage: ./run_parallel.sh [browser]
BROWSER=${1:-chrome}
pabot --processes 8 --variable BROWSER:${BROWSER} --outputdir results/reports tests/