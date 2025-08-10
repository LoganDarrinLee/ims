#!/bin/bash

# Exit on error 
set -e

# Export all variables from .env
export $(grep -v '^#' .env | xargs)


if [[ -f "build/ims" ]]; then
  ./build/ims dumpschema 
fi

# If dump unsuccessful, exit to avoid errors.
if [ $? -eq 0 ]; then
    exit 0
else 
    echo "[Error] Failed to dump database schema."
    exit 1
fi 
