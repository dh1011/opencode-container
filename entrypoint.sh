#!/bin/bash

# Function to check if a host is resolvable
can_resolve() {
    getent hosts "$1" >/dev/null 2>&1
}

echo "--- Configuring Display ---"

# Attempt 1: Try host.docker.internal (Docker Desktop standard)
if can_resolve "host.docker.internal"; then
    export DISPLAY=host.docker.internal:0.0
    echo "Mode: Docker Desktop detected."
    echo "Display set to: $DISPLAY"

# Attempt 2: Try the default network gateway (Podman / WSL2 standard)
else
    # Get the default gateway IP using ip route
    HOST_IP=$(ip route show default | awk '/default/ {print $3}')
    export DISPLAY=$HOST_IP:0.0
    echo "Mode: Podman/WSL detected."
    echo "Display set to: $DISPLAY"
fi

echo "---------------------------"

# Execute the command passed to the docker run command
exec "$@"
