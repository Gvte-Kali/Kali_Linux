#!/usr/bin/zsh

# Function to check if the Docker container is already running
function is_openvas_running {
    sudo docker ps | grep -q 'openvas'
}

# Function to wait until the web server returns a 200 status code
function wait_for_webserver {
    while true; do
        response=$(curl -k -s -o /dev/null -w "%{http_code}" https://127.0.0.1/login/login.html)
        if [[ "$response" == "200" ]]; then
            break
        fi
        sleep 5
    done
    sleep 10  # 10 seconds pause after detecting the web server is up
}

# Function to close the OpenVAS instance
function close_openvas {
    echo -e "${YELLOW}Closing the OpenVAS instance...${NC}"
    sudo docker stop openvas
    sudo docker rm openvas
    echo -e "${YELLOW}The OpenVAS instance is now closed.${NC}"
    read -n 1 -s -r -p "Press any key to close the program..."
    exit 0
}

# Text colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Navigate to the specified directory
cd /home/kali/Sandbox

# Check if the Docker container openvas is already running
if is_openvas_running; then
    echo -e "${YELLOW}The OpenVAS container is already running. Stopping the existing instance...${NC}"
    sudo docker stop openvas
    sudo docker rm openvas
    echo -e "${YELLOW}Existing instance stopped.${NC}"
fi

# Pull the Docker image for OpenVAS
echo -e "${BLUE}\nDownloading the Docker image for OpenVAS...${NC}"
sudo docker pull mikesplain/openvas

# Start the Docker container for OpenVAS
echo -e "${BLUE}\nStarting the OpenVAS instance...${NC}"
sudo docker run -d -p 443:443 --name openvas mikesplain/openvas

# Wait for the web server to be functional
echo -e "${BLUE}\nWaiting for the web server to be functional...${NC}"
wait_for_webserver
echo -e "${GREEN}The web server is now functional.${NC}"

# Check if a web browser is open
if pgrep -x "firefox" > /dev/null || pgrep -x "chrome" > /dev/null || pgrep -x "brave" > /dev/null; then
    echo -e "${BLUE}A web browser is already open. Opening a new tab...${NC}"
    xdg-open https://127.0.0.1 &
else
    echo -e "${BLUE}Launching the default web browser with the URL...${NC}"
    xdg-open https://127.0.0.1 &
fi

# Display a message indicating that the instance is open
echo -e "${GREEN}The OpenVAS instance is now open.${NC}"

# Enter a loop to monitor user inputs
while true; do
    read -p "Enter 'exit', 'quit', 'close', or 'kill' to close the instance: " input
    if [[ "$input" == "exit" || "$input" == "quit" || "$input" == "close" || "$input" == "kill" ]]; then
        close_openvas
    else
        echo -e "${RED}Unrecognized command. Please enter 'exit', 'quit', 'close', or 'kill'.${NC}"
    fi
done
