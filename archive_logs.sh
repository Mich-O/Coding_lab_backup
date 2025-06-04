#!/bin/bash

# Define log directories
ACTIVE_LOGS_DIR="hospital_data/active_logs"
ARCHIVE_LOGS_DIR="hospital_data/archived_logs"

# Log file options and archive directories
declare -A LOG_OPTIONS=(
  [1]="heart_rate_log.log"
  [2]="temperature_log.log"
  [3]="water_usage_log.log"
)
declare -A ARCHIVE_DIRS=(
  [1]="heart_data_archive"
  [2]="temperature_data_archive"
  [3]="water_usage_data_archive"
)

# Function to display the menu
show_menu() {
  echo "Select log to archive:"
  echo "1) Heart Rate"
  echo "2) Temperature"
  echo "3) Water Usage"
  echo "Enter choice (1-3): "
}

# Function to archive the selected log
archive_log() {
  local choice=$1
  local log_file="${LOG_OPTIONS[$choice]}"
  local archive_dir="${ARCHIVE_DIRS[$choice]}"
  local now=$(date "+%Y-%m-%d_%H:%M:%S")
  local archive_file="${log_file%.log}_${now}.log"

  # Check if log file exists
  if [ ! -f "$ACTIVE_LOGS_DIR/$log_file" ]; then
    echo "Error: $log_file not found in $ACTIVE_LOGS_DIR"
    return 1
  fi

  # Check if archive directory exists
  if [ ! -d "$ARCHIVE_LOGS_DIR/$archive_dir" ]; then
    echo "Error: Archive directory $ARCHIVE_LOGS_DIR/$archive_dir not found"
    return 1
  fi

  # Move and rename the log file
  mv "$ACTIVE_LOGS_DIR/$log_file" "$ARCHIVE_LOGS_DIR/$archive_dir/$archive_file"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to archive $log_file"
    return 1
  fi

  # Create a new empty log file
  touch "$ACTIVE_LOGS_DIR/$log_file"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create new $log_file"
    return 1
  fi

  echo "Successfully archived to $ARCHIVE_LOGS_DIR/$archive_dir/$archive_file"
}

# Main script logic
show_menu

read -r choice

# Validate user input
if ! [[ "$choice" =~ ^[1-3]$ ]]; then
  echo "Invalid choice. Please enter a number between 1 and 3."
  exit 1
fi

archive_log "$choice"
