#!/bin/bash

# Exit on error 
set -e

# Export all variables from .env
export $(grep -v '^#' .env | xargs) 

if [[ -f "build/ims" ]]; then
  ./build/ims migrate 
fi

# If migration unsuccessful, exit to avoid errors with sqlc generation.
if [ $? -eq 0 ]; then
    exit 0
else 
    echo "[Error] Failed to migrate database."
    exit 1
fi 


