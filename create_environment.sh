#!/bin/bash

# Prompt the user for their name
read -p "Please enter your name to create the main directory: " userName

# Define the main directory name
dir_name="submission_reminder_${userName}"

# Check if the directory already exists

 if [ -d "$dir_name" ]; then
  echo "Directory '$dir_name' already exists. Please remove it or choose a different name."
  exit 1
fi

echo "Creating project structure in directory: ${dir_name}"

# --- Create Directory Structure ---
# The -p flag ensures that parent directories are created if they don't exist.
mkdir -p "${dir_name}/app"
mkdir -p "${dir_name}/assets"
mkdir -p "${dir_name}/config"
mkdir -p "${dir_name}/modules"

echo "Directory structure created successfully."

# Using 'touch' to create empty files first.
touch "${dir_name}/startup.sh"
touch "${dir_name}/app/reminder.sh"
touch "${dir_name}/assets/submissions.txt"
touch "${dir_name}/config/config.env"
touch "${dir_name}/modules/functions.sh"

# We use 'cat << EOF >' to write multi-line content into each file.
# 1. config/config.env
cat << EOF > "${dir_name}/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# 2. modules/functions.sh
cat << EOF > "${dir_name}/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# 3. assets/submissions.txt
cat << EOF > "${dir_name}/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
EOF

# 4. app/reminder.sh
cat << EOF > "${dir_name}/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# 5. startup.sh
cat << EOF > "${dir_name}/startup.sh"

