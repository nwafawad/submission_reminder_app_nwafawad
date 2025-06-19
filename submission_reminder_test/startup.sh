#!/bin/bash

# Startup script for submission reminder app
echo "Starting Submission Reminder App..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Extract the parent directory name (e.g., submission_reminder_Nawaf)
parent_dir_name=$(basename "$(dirname "$SCRIPT_DIR")")

# Check if the parent directory matches submission_reminder_*
if [[ "$parent_dir_name" == submission_reminder_* ]]; then
  # Script is in the nested directory (e.g., /Users/Apple/submission_reminder_Nawaf/submission_reminder_John)
  target_dir="$SCRIPT_DIR"
else
  # Script is in the base directory (e.g., /Users/Apple/submission_reminder_Nawaf)
  # Look for a nested submission_reminder_* directory
  nested_dirs=("$SCRIPT_DIR"/submission_reminder_*)
  if [ -d "${nested_dirs[0]}" ] && [ "${#nested_dirs[@]}" -eq 1 ]; then
    target_dir="${nested_dirs[0]}"
  else
    echo "Error: Could not find a single submission_reminder_* directory in $SCRIPT_DIR"
    exit 1
  fi
fi

# Check if the target directory exists
if [ ! -d "$target_dir" ]; then
  echo "Error: Directory $target_dir not found."
  exit 1
fi

# Source configuration using absolute path
if ! source "$target_dir/config/config.env"; then
  echo "Error: Failed to source $target_dir/config/config.env"
  exit 1
fi

# Change to the app directory using absolute path to ensure relative paths in reminder.sh work
if ! cd "$target_dir/app"; then
  echo "Error: Failed to change to $target_dir/app directory"
  exit 1
fi

# Run the reminder script
if ! bash ./reminder.sh; then
  echo "Error: Failed to run reminder.sh"
  exit 1
fi

echo "Submission Reminder App completed."
