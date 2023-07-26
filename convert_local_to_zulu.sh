#!/bin/bash

# Function to convert local time to Zulu time
convert_to_zulu_time() {
    local_time="$1"

    # Check if date command supports the "--date" option (GNU version)
    if date --help 2>&1 | grep -q "date.*--date"; then
        zulu_time=$(date --date="$local_time" -u +%Y-%m-%dT%H:%M:%SZ)
    else
        # Fallback for macOS (BSD version of date)
        # Convert to seconds since epoch (UTC), and format back to Zulu time
        utc_time=$(date -jf "%Y-%m-%d %H:%M:%S" "$local_time" "+%s")
        zulu_time=$(date -u -r "$utc_time" "+%Y-%m-%dT%H:%M:%SZ")
    fi

    echo "Local time: $local_time"
    echo "Zulu time: $zulu_time"
}

# Example usage: Pass the local time as an argument to the script
if [ -z "$1" ]; then
    echo "Usage: $0 <LOCAL_TIME>"
else
    convert_to_zulu_time "$1"
fi
