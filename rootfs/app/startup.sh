#!/bin/sh

# Startup script for ntfy
echo "using the following configs"
cat /etc/ntfy/server.yml

# Run ntfy
ntfy serve &

# Get its process ID
ntfy_pid=$!

# Wait for ntfy to start
sleep 5

# Check if the user database exists. If not, create an initial user.
if [ ! -f "${NTFY_AUTH_FILE}" ]; then
  echo "Creating initial user..."
  ntfy user add --role=admin Admin
fi

wait $ntfy_pid
