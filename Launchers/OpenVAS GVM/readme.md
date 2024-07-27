# OpenVAS Launch Script

## Overview

This script automates the process of managing an OpenVAS Docker container and launching the Brave browser. It handles starting and stopping the OpenVAS container, waits for the web server to become responsive, and opens the Brave browser to the OpenVAS web interface. 

## Script Description

- **Checks if the OpenVAS Docker container is already running**: If it is, the script stops and removes the existing container before starting a new instance.
- **Pulls the OpenVAS Docker image**: Ensures you have the latest image.
- **Starts the OpenVAS Docker container**: Runs OpenVAS on port 443.
- **Waits for the web server to be responsive**: Checks if the server is up by querying a specific URL and waits until it receives a 200 HTTP status code.
- **Launches Brave browser**: Opens a new tab in Brave with the OpenVAS interface. If Brave is already running, it opens a new tab; otherwise, it launches Brave with the specified profile.
- **Provides a user interface for stopping the OpenVAS instance**: Continuously monitors user input and shuts down the OpenVAS container when commands like 'exit', 'quit', 'close', or 'kill' are received.

## Usage Instructions

1. **Save the Script**

   Save the script to a file, for example, `launch_openvas.sh`.

2. **Make the Script Executable**

   Run the following command to make the script executable:
   ```bash
   sudo chmod +x launch_openvas.sh
