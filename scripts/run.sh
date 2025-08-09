# Run development server on local device

# Export all variables from .env
export $(grep -v '^#' .env | xargs)


if [[ -f "build/ims" ]]; then
  ./build/ims start 
fi
 
