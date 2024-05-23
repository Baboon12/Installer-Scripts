#!/bin/bash

scripts=("beef.sh" "metagoofil.sh" "theHarvester.sh" "whatweb.sh" "hydra.sh" "gobuster.sh" "reconng.sh" "nmap.sh" "nikto.sh" "dnsrecon.sh" "dnsenum.sh" "dirsearch.sh" "wfuzz.sh" "websocket-client.sh" "httprint.sh" "unicornscan.sh" "curl.sh")

while true; do
  echo "What tool do you want to install?"
  select choice in "beef" "metagoofil" "theHarvester" "whatWeb" "hydra" "gobuster" "reconng" "nmap" "nikto" "dnsrecon" "dnsenum" "dirsearch" "wfuzz" "websocket-client" "httprint" "unicornscan" "curl" "exit"; do
    case "$choice" in
      "exit")
        echo "Exiting..."
        exit 0
        ;;
      *)
        script=${scripts[$REPLY-1]}
        if [ -x "./scripts/$script" ]; then
          echo "Running $script..."
          ./scripts/"$script"
        else
          echo "Error: Script $script not found or not executable."
          exit 1
        fi
        break
        ;;
    esac
  done
done
