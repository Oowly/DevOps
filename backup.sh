#!/bin/bash

display_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -d, --directory    Directory to backup"
    echo "  -c, --compression  Compression algorithm (none, gzip, bzip, etc)"
    echo "  -o, --output       Output file name"
    echo "  -h, --help         Display this help message"
    exit 1
}

create_backup() {
    local directory="$1"
    local compression="$2"
    local output_file="$3"
    local error_log="error.log"
 
    exec 3>&1 4>&2 1>>"$error_log" 2>&1

    tar cf - "$directory" | $compression -c | openssl enc -aes-256-cbc -salt -out "$output_file"

    exec 1>&3 2>&4

    echo "Backup created successfully and stored in $output_file"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--directory)
            DIRECTORY=$2
            shift
            ;;
        -c|--compression)
            COMPRESSION=$2
            shift
            ;;
        -o|--output)
            OUTPUT_FILE=$2
            shift
            ;;
        -h|--help)
            display_help
            ;;
        *)
            echo "Invalid option: $1"
            display_help
            ;;
    esac
    shift
done

if [ -z "$DIRECTORY" ] || [ -z "$COMPRESSION" ] || [ -z "$OUTPUT_FILE" ]; then
    echo "Error: Missing required parameters. Use -h/--help for usage."
    exit 1
fi

if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory $DIRECTORY does not exist."
    exit 1
fi

if ! command -v "$COMPRESSION" &> /dev/null; then
    echo "Error: Invalid compression algorithm."
    exit 1
fi

create_backup "$DIRECTORY" "$COMPRESSION" "$OUTPUT_FILE"
