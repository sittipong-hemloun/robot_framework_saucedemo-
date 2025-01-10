#!/bin/bash
# Usage: ./run_smoke.sh [browser]
BROWSER=${1:-chrome}
robot -d results/reports -v BROWSER:${BROWSER} tests/ui/smoke