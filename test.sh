#!/bin/bash

# Path to the Node.js script (adjust if the file name is different)
SCRIPT="sort.js"

# Check if the script exists
if [ ! -f "$SCRIPT" ]; then
    echo "Error: $SCRIPT not found!"
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is not installed!"
    exit 1
fi

# Counter for passed and total tests
PASSED=0
TOTAL=0

# Function to run a test case
run_test() {
    local width=$1
    local height=$2
    local length=$3
    local mass=$4
    local expected=$5
    local description=$6

    ((TOTAL++))
    echo -n "Test $TOTAL: $description... "
    result=$(node "$SCRIPT" "$width" "$height" "$length" "$mass" 2>/dev/null)

    if [ "$result" = "$expected" ]; then
        echo "PASS"
        ((PASSED++))
    else
        echo "FAIL (Expected: $expected, Got: $result)"
    fi
}

# Test cases for correct sorting logic
run_test 100 100 99 15 "STANDARD" "Standard package (not bulky, not heavy)"
run_test 150 100 100 15 "SPECIAL" "Bulky due to width >= 150 cm"
run_test 100 99 100 20 "SPECIAL" "Heavy due to mass >= 20 kg"
run_test 150 100 100 20 "REJECTED" "Both bulky and heavy"
run_test 100 100 1000 15 "SPECIAL" "Bulky due to volume >= 1,000,000 cm³"

# Test cases for edge cases
run_test 99.99 99.99 99.99 19.99 "STANDARD" "Just below bulky and heavy thresholds"
run_test 150 149.99 149.99 19.99 "SPECIAL" "Exactly at width = 150 cm"
run_test 99 100 100 20 "SPECIAL" "Exactly at mass = 20 kg"
run_test 100 100 1000 19.99 "SPECIAL" "Exactly at volume = 1,000,000 cm³"
run_test 0 100 100 15 "ERROR" "Zero dimension (not bulky, not heavy)"
run_test 100 100 100 0 "ERROR" "Zero mass (not bulky, not heavy)"

# Test cases for invalid inputs
run_test 100 100 100 "" "ERROR" "Missing mass argument"
run_test 100 100 "" 10 "ERROR" "Missing length and mass arguments"
run_test "" "" "" "" "ERROR" "No arguments provided"
run_test abc 100 100 15 "ERROR" "Non-numeric width argument"

# Summary
echo "---------------------"
echo "Test Summary: $PASSED/$TOTAL tests passed"
if [ $PASSED -eq $TOTAL ]; then
    echo "All tests passed successfully!"
else
    echo "Some tests failed."
    exit 1
fi