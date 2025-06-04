#!/bin/bash

# Define directories
ACTIVE_LOGS_DIR="hospital_data/active_logs"
REPORTS_DIR="hospital_data/reports"
REPORT_FILE="${REPORTS_DIR}/analysis_report.txt"

# Display menu
echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate_log.log)"
echo "2) Temperature (temperature_log.log)"
echo "3) Water Usage (water_usage_log.log)"
read -p "Enter choice (1-3): " choice

# Process user choice
case $choice in
    1)
        log_file="${ACTIVE_LOGS_DIR}/heart_rate_log.log"
        log_type="Heart Rate"
        ;;
    2)
        log_file="${ACTIVE_LOGS_DIR}/temperature_log.log"
        log_type="Temperature"
        ;;
    3)
        log_file="${ACTIVE_LOGS_DIR}/water_usage_log.log"
        log_type="Water Usage"
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac

# Check if log file exists
if [ ! -f "$log_file" ]; then
    echo "Error: Log file $log_file does not exist."
    exit 1
fi

# Create report header
echo -e "\n=== Analysis Report for $log_type ===" > "$REPORT_FILE"
echo "Generated on: $(date)" >> "$REPORT_FILE"
echo "---------------------------------" >> "$REPORT_FILE"

# Count occurrences of each device
echo -e "\nDevice Counts:" >> "$REPORT_FILE"
awk '{print $3}' "$log_file" | sort | uniq -c | awk '{print $2 ": " $1 " entries"}' >> "$REPORT_FILE"

# Get first and last timestamps for each device
echo -e "\nFirst and Last Entries:" >> "$REPORT_FILE"
for device in $(awk '{print $3}' "$log_file" | sort | uniq); do
    first=$(grep "$device" "$log_file" | head -n 1 | awk '{print $1, $2}')
    last=$(grep "$device" "$log_file" | tail -n 1 | awk '{print $1, $2}')
    echo "$device:" >> "$REPORT_FILE"
    echo "  First entry: $first" >> "$REPORT_FILE"
    echo "  Last entry: $last" >> "$REPORT_FILE"
done

echo -e "\nAnalysis complete. Results saved to $REPORT_FILE"
cat "$REPORT_FILE"
