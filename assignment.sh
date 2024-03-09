#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 [-d] [-n N] directory"
    echo "Options:"
    echo "  -d: List all files and directories within the specified directory/directories."
    echo "  -n N: Return the top N entries by disk usage. Default is 8."
    exit 1
}

# Default values
list_files=false
num_entries=8

# Parse command-line options
while getopts ":dn:" opt; do
    case $opt in
        d)
            list_files=true
            ;;
        n)
            num_entries=$OPTARG
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            ;;
    esac
done

# Shift the options so that the directory argument is at index 1
shift $((OPTIND - 1))

# Check if the directory argument is provided
if [ $# -eq 0 ]; then
    echo "Error: Directory argument is missing."
    usage
fi

# Check if the directory exists
directory=$1
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    usage
fi

# Display disk usage
echo "Disk usage in directory '$directory':"
if [ "$list_files" = true ]; then
    du -ah "$directory" | sort -rh | head -n "$num_entries"
else
    du -h "$directory" | sort -rh | head -n "$num_entries"
fi
