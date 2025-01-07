#!/bin/bash

# Run the Python script using Unix-style path
echo "Running Python script to convert YAML to JSON..."
python "/c/Users/Ashtar - Exaba/Documents/lang_test/convert_yaml_to_json.py"

# Check if the Python script ran successfully
if [ $? -ne 0 ]; then
  echo "Python script failed. Aborting build."
  exit 1
fi

# Run the Flutter build
echo "Running Flutter build..."
flutter build "$@"

# After build is done, run the app
echo "Running Flutter app..."
flutter run
