set -e 

source .env

if [[ -f "build/ims" ]]; then
  echo "Clearing previous build."
  rm -rf build/ims
fi

go build -o build/ims main.go

./build/ims --help
