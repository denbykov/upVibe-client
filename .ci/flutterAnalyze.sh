#!/bin/bash

# Run flutter analyze command and capture the output
output=$(flutter analyze)

# Print the output
echo "$output"

# Check if the output contains the word "error"
if [[ $output == *error* ]]; then
    echo "Error(s) found in flutter analyze output"
    exit 1 # Exit with error code
else
    echo "No errors found in flutter analyze output"
    exit 0 # Exit with success code
fi
