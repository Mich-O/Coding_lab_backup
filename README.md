Hospital Data Monitoring & Archival System
Project Objective
Develop an automated log management system that:

Collects real-time patient health metrics and resource usage data

Provides controlled log archiving with user selection

Generates analytical reports with device statistics and temporal patterns

Demonstrates proficiency in:

Interactive shell scripting
Log file processing
Data analysis with Linux tools

System Setup (Provided Materials)
Python Simulators
Click on the names and open them in a new tab. You will copy the content of each file, then create a similar filename in the sandbox then proceed with the next steps detailed in part 3 (Initialization):

heart_monitor.py - Simulates 2 heart rate monitors
temp_sensor.py - Simulates 2 temperature sensors
water_meter.py - Simulates water usage

Directory Structure:
image.png
Initialization:
# Start monitoring devices (run in separate terminals)
python3 heart_monitor.py start
python3 temp_sensor.py start
python3 water_meter.py start

# Verify data collection
tail -f hospital_data/active_logs/heart_rate.log
Required Tasks
Task 1: Interactive Archival Script (archive_logs.sh)
Requirements:

Implement a feature so that when the script is run, you are prompted by a numbered menu of log types to choose a running log file to archive:
1) heart_rate_log.log
2) temperature_log.log
3) water_usage_log.log
Archives only the selected log type by:

Moving the active log to its designated archive folder
Renaming with timestamp: heart_rate_YYYY-MM-DD_HH:MM:SS.log
Creating a new empty log file for continued monitoring
Includes error handling for:

Invalid user input
Missing log files
Archive directory issues
Example Usage:

$ ./archive_logs.sh
Select log to archive:
1) Heart Rate
2) Temperature
3) Water Usage
Enter choice (1-3): 1

Archiving heart_rate.log...
Successfully archived to heart_data_archive/heart_rate_2024-06-18_15:22:10.log
Task 2: Intelligent Analysis Script (analyze_logs.sh)
Script Requirements
Interactive Prompt:

When executed, the script must present this menu:

Select log file to analyze:
1) Heart Rate (heart_rate.log)
2) Temperature (temperature.log)
3) Water Usage (water_usage.log)
Enter choice (1-3):
Validates user input (only 1,2, or 3)
Analysis Functionality:

Counts occurrences of each device in the selected log file

Records both:

Total count per device
Timestamp of first/last entry (bonus)
Reporting: Appends results to reports/analysis_report.txt

Commands to use potentially
Task	Essential Commands
Archival	date, mv, touch, select/case, test
Analysis	awk, grep, sort, uniq, head, tail
Reporting	echo, >>, date
 

Submission instructions
Submit a GitHub repository with the name "Coding-lab_Group{nbr}"
The GitHub repository must contain the following:
archive_logs.sh
analyze_logs.sh
Readme.md (To document how the application works)
temperature_recorder.py
heart_rate_monitor.py
water_consumption.py
LEARNING OBJECTIVES 
1. Shell Scripting Proficiency

Develop interactive scripts with user menus (select/case)
Master file operations (mv, touch, awk, grep)
Implement error handling and input validation
2. Log Management & Automation

Design structured archival systems with timestamping
Automate log rotation without disrupting active processes
Organize files into dedicated directories programmatically
3. Data Analysis with CLI Tools

Extract insights from logs using awk, sort, uniq
Generate formatted reports with device statistics
Append results to the cumulative analysis files
