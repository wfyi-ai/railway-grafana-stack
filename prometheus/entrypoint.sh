#!/bin/sh

# fail if environment variable is not set
if [ -z "$FYLFLIX_TARGET" ]; then
  echo "Error: FYLFLIX_TARGET environment variable is not set"
  exit 1
fi

# Create a temporary config file with the variable replaced
# We use output redirection because we might not have write permission to the original file
# We use listing | as delimiter in sed to avoid issues if the URL contains slashes /
sed "s|\${FYLFLIX_TARGET}|$FYLFLIX_TARGET|g" /etc/prometheus/prom.yml > /tmp/prom-env.yml

# Run Prometheus using the new config file
exec /bin/prometheus \
    --config.file=/tmp/prom-env.yml \
    --storage.tsdb.path=/prometheus \
    --web.console.libraries=/usr/share/prometheus/console_libraries \
    --web.console.templates=/usr/share/prometheus/consoles