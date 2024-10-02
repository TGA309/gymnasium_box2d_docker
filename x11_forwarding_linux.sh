#!/bin/bash

# Check if running on Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Running on Linux. No need for VcXsrv."

    # Get the system's IPv4 address
    IP=$(hostname -I | awk '{print $1}')

    # Write the DISPLAY variable with the system IP to the .env file
    echo "Writing DISPLAY variable to .env file..."
    echo "DISPLAY=${IP}:0.0" > .env

    # Set the DISPLAY environment variable
    export DISPLAY="${IP}:0.0"
    echo "Setting DISPLAY environment variable to ${DISPLAY}"

    # Inform the user that the system is configured
    echo "System configured for X11 forwarding on Linux."

else
    echo "This script is designed to run on Linux systems."
fi