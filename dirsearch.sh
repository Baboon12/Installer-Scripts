#!/bin/bash

# Check if the script is being run with sudo
if [[ $EUID -ne 0 ]]; then
  echo "Please run this script with sudo."
  exit 1
fi

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git and try again."
    exit 1
fi

echo "Checking python and pip installation" 
if ! command -v python3 &> /dev/null || ! command -v pip3 &> /dev/null; then
    echo "python/pip installation Not Found" 
    exit 1
fi

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
elif [ -f /etc/debian_version ]; then
    OS=debian
elif [ -f /etc/fedora-release ]; then
    OS=fedora
elif [ -f /etc/redhat-release ]; then
    if grep -q "CentOS" /etc/redhat-release; then
        OS=centos
    else
        OS=rhel
    fi
else
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
fi

git clone https://github.com/maurosoria/dirsearch.git || { echo "Failed to clone dirsearch repository."; exit 1; }
cd dirsearch
pip3 install -r requirements.txt || { echo "Failed to install dirsearch dependencies. Please try again."; exit 1; }
./dirsearch.py -h
echo "Dirsearch Installed Successfully"