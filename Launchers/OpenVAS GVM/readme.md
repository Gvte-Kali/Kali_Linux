# OpenVAS Launch Script

## Overview

This script automates the management of an OpenVAS Docker container and the launching of the default web browser. It handles starting and stopping the OpenVAS container, waiting for the web server to become responsive, and opening the default browser to access the OpenVAS web interface.

## Script Description

- **Checks if the OpenVAS Docker container is already running**: If an instance is running, it stops and removes the existing container before starting a new one.
- **Pulls the OpenVAS Docker image**: Ensures you have the latest image available.
- **Starts the OpenVAS Docker container**: Runs OpenVAS on port 443.
- **Waits for the web server to be responsive**: Verifies if the server is up by querying a specific URL and waits until it receives a 200 HTTP status code.
- **Launches the default web browser**: Opens the default browser to the OpenVAS interface. If a browser is already open, it opens a new tab; otherwise, it launches the default browser.
- **Provides a user interface for stopping the OpenVAS instance**: Monitors user input continuously and shuts down the OpenVAS container when commands such as 'exit', 'quit', 'close', or 'kill' are received.

## Usage Instructions

1. **Save the Script**

   Save the script to a file, for example, `launch_openvas.sh`.

2. **Make the Script Executable**

   Run the following command to make the script executable:
   ```bash
   sudo chmod +x launch_openvas.sh

### OPTIONNAL
3. **Add a shortcut**

   Download the OpenVAS_gvm.desktop file, open it and modify the line '''"Exec=bash path_to_file.sh"''' with your path to the script

4. **Make the Desktop File Executable**

   Run the following command to make the script executable:
   ```bash
   sudo chmod +x OpenVAS_gvm.desktop
