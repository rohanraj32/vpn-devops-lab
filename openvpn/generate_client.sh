#!/bin/bash

# Check if client name argument was provided
if [ -z "$1" ]; then
    echo "Error: Please provide a client name."
    echo "Usage: ./generate_client.sh <client_name>"
    exit 1
fi

CLIENT_NAME=$1

echo "Creating VPN client profile for: $CLIENT_NAME"

# Generate client credentials inside the running OpenVPN Docker container
docker exec -it openvpn_server easyrsa build-client-full "$CLIENT_NAME" nopass

# Output the combined .ovpn configuration file
docker exec -it openvpn_server ovpn_getclient "$CLIENT_NAME" > "./${CLIENT_NAME}.ovpn"

echo "Success! Config generated at ./${CLIENT_NAME}.ovpn"