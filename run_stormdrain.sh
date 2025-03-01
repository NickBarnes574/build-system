#!/bin/bash

# Define the path to the `stormdrain` executable
STORMDRAIN_PATH="./build/artifacts/x86_64/install/bin/stormdrain"

# Check if the `stormdrain` executable exists
if [ -x "$STORMDRAIN_PATH" ]; then
    echo "Running stormdrain..."
    "$STORMDRAIN_PATH"
else
    echo "Error: stormdrain executable not found at $STORMDRAIN_PATH"
    echo "Please ensure the program is built and installed correctly."
    exit 1
fi
