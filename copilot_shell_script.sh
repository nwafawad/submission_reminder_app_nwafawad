#!/bin/bash

#script to update the current assignment and the list of submitted students.
# This script should be run from within the main project directory.
CONFIG_FILE="./config/config.env"
SUBMISSIONS_FILE="./assets/submissions.txt"

# --- Check if required files exist ---
if [ ! -f "$CONFIG_FILE" ] || [ ! -f "$SUBMISSIONS_FILE" ]; then
  echo "Error: Cannot find required files."
  echo "Please make sure you are in the correct project directory (e.g., submission_reminder_surname/)"
  echo "and that the 'config/config.env' and 'assets/submissions.txt' files exist."
  exit 1
fi
# Update Current Assignment
echo "The current assignment is: $(grep CURRENT_ASSIGNMENT $CONFIG_FILE | cut -d'=' -f2)"
read -p "Enter the new assignment name: " new_assignment
