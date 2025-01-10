#!/bin/bash
# Usage: ./run_tests.sh [browser]
BROWSER=${1:-chrome}
robot -d results/reports -v BROWSER:${BROWSER} tests/