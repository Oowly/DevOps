# Backup Script

This Bash script is designed to create an encrypted backup of a specified directory using various compression algorithms. It accepts parameters for the directory to backup, compression algorithm, and the output file name.

## Parameters
    -d, --directory: The directory to backup.
    -c, --compression: Compression algorithm to use (none, gzip, bzip, etc; see tar for details).
    -o, --output: Output file name.

## Options
    -h, --help: Display help information.

## Functionality
The script compresses the specified directory using the chosen compression algorithm.

The compressed data is then encrypted using OpenSSL with AES-256-CBC and a salt.

The encrypted backup is saved to the specified output file.

## Logging
All output, except errors, is redirected to an error log file (error.log). Errors are written to this log file.

## Usage
```bash
./backup.sh -d /path/to/backup -c compression_algorithm -o output_file

