#!/bin/bash

# Function to convert Zulu time to local time
convert_to_local_time() {
    zulu_time="$1"

    # Check if date command supports the "--date" option (GNU version)
    if date --help 2>&1 | grep -q "date.*--date"; then
        local_time=$(date --date="$zulu_time" +%Y-%m-%d\ %H:%M:%S)
    else
        # Fallback for macOS (BSD version of date)
        # Convert to seconds since epoch, add local timezone offset, and format back to local time
        local_time=$(date -jf "%Y-%m-%dT%H:%M:%SZ" "$zulu_time" "+%Y-%m-%d %H:%M:%S")
    fi

    echo "Zulu time: $zulu_time"
    echo "Local time: $local_time"
}

# Example usage: Pass the Zulu time as an argument to the script
if [ -z "$1" ]; then
    echo "Usage: $0 <ZULU_TIME>"
else
    convert_to_local_time "$1"
fi
