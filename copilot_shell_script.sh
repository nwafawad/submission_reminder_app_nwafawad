#!/bin/bash
# A script that prompts the user for a new assignment name and updates it

# Define the path to the configuration file
CONFIG_FILE="./config/config.env"
#Pre-run Check
# Ensure the script is being run from the correct project directory
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Configuration file not found at '$CONFIG_FILE'."
  echo "Please navigate to the root project directory (e.g., submission_reminder_yourname/) before running this script."
  exit 1
fi
#--Update the Assignment Name
echo "The current assignment is: $(grep 'ASSIGNMENT=' "$CONFIG_FILE" | cut -d'=' -f2)"
read -p "Please enter the new assignment name: " new_assignment
# sed ommand to find the line starting with 'ASSIGNMENT=' and replace its value.
# The '-i' flag edits the file directly (in-place).
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$CONFIG_FILE"

echo "Success! The assignment has been updated in $CONFIG_FILE."
echo ""


