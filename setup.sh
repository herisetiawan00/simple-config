#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

if [[ "$OSTYPE" == "linux"* ]]; then
        echo "Detected Linux. Running Linux setup..."
        chmod +x ./setup/linux/setup.sh
        ./setup/linux/setup.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Detected macOS. Running macOS setup..."
        chmod +x ./setup/macos/setup.sh
        ./setup/macos/setup.sh
else
        echo "Error: Unsupported OS ($OSTYPE)"
        exit 1
fi
