# BusyBox Interactive Learning Package

A hands-on guide to master BusyBox commands through practical exercises, custom scripts, and real-world problem-solving.

---

## Table of Contents
1. [Practice Exercises](#practice-exercises)
2. [Custom Useful Scripts](#custom-useful-scripts)
3. [Common Problems & Solutions](#common-problems--solutions)
4. [Deep Dive Tutorials](#deep-dive-tutorials)
5. [Command Testing Lab](#command-testing-lab)
6. [Troubleshooting Guide](#troubleshooting-guide)

---

## Practice Exercises

### Exercise Set 1: File Operations Basics

**Exercise 1.1: File Creation and Manipulation**
```bash
# Create a practice directory
mkdir ~/busybox_practice
cd ~/busybox_practice

# Create test files
echo "Hello World" > file1.txt
echo "BusyBox Tutorial" > file2.txt
echo "Learning Commands" > file3.txt

# Tasks:
# 1. List all files with details
# 2. Copy file1.txt to file1_backup.txt
# 3. Rename file2.txt to tutorial.txt
# 4. Combine all files into combined.txt
# 5. Count total lines in all files

# Solutions:
ls -lh
cp file1.txt file1_backup.txt
mv file2.txt tutorial.txt
cat file1.txt tutorial.txt file3.txt > combined.txt
wc -l *.txt
```

**Exercise 1.2: Directory Navigation**
```bash
# Create nested directories
mkdir -p project/{src,docs,tests}

# Tasks:
# 1. Navigate to project/src
# 2. Create a file called main.sh
# 3. Go back to project directory
# 4. List directory structure
# 5. Find all .sh files

# Solutions:
cd project/src
touch main.sh
cd ../..
ls -R project/
find project/ -name "*.sh"
```

**Exercise 1.3: File Permissions**
```bash
# Create a script file
echo '#!/bin/sh' > script.sh
echo 'echo "Hello from script"' >> script.sh

# Tasks:
# 1. Check current permissions
# 2. Make it executable
# 3. Run the script
# 4. Change permissions to read-only
# 5. Verify permissions changed

# Solutions:
ls -l script.sh
chmod +x script.sh
./script.sh
chmod 444 script.sh
ls -l script.sh
```

### Exercise Set 2: Text Processing

**Exercise 2.1: Searching with grep**
```bash
# Create sample log file
cat > sample.log << 'EOF'
2025-10-29 10:00:00 INFO User logged in
2025-10-29 10:05:23 ERROR Connection failed
2025-10-29 10:10:45 INFO Data processed
2025-10-29 10:15:12 ERROR Timeout occurred
2025-10-29 10:20:33 WARNING Low memory
2025-10-29 10:25:01 INFO User logged out
EOF

# Tasks:
# 1. Find all ERROR lines
# 2. Count how many ERROR lines exist
# 3. Find lines with "User" (case-insensitive)
# 4. Show line numbers with WARNING
# 5. Find lines that don't contain ERROR

# Solutions:
grep "ERROR" sample.log
grep -c "ERROR" sample.log
grep -i "user" sample.log
grep -n "WARNING" sample.log
grep -v "ERROR" sample.log
```

**Exercise 2.2: Text Transformation with sed**
```bash
# Create sample data
cat > data.txt << 'EOF'
Name: John Doe
Age: 30
City: New York
Status: Active
EOF

# Tasks:
# 1. Replace "John Doe" with "Jane Smith"
# 2. Delete the line containing "Age"
# 3. Add a new line after "City"
# 4. Replace all colons with equal signs
# 5. Convert all to uppercase (use tr)

# Solutions:
sed 's/John Doe/Jane Smith/' data.txt
sed '/Age/d' data.txt
sed '/City/a\Country: USA' data.txt
sed 's/:/=/g' data.txt
tr '[:lower:]' '[:upper:]' < data.txt
```

**Exercise 2.3: Data Analysis with awk**
```bash
# Create sample sales data
cat > sales.csv << 'EOF'
Product,Quantity,Price
Apple,10,1.50
Banana,20,0.75
Orange,15,2.00
Grape,25,3.50
EOF

# Tasks:
# 1. Print only product names
# 2. Calculate total revenue for each product (Quantity * Price)
# 3. Find products with quantity > 15
# 4. Calculate total revenue for all products
# 5. Format output as a table

# Solutions:
awk -F',' 'NR>1 {print $1}' sales.csv
awk -F',' 'NR>1 {printf "%s: $%.2f\n", $1, $2*$3}' sales.csv
awk -F',' 'NR>1 && $2>15 {print $1, $2}' sales.csv
awk -F',' 'NR>1 {sum+=$2*$3} END {printf "Total: $%.2f\n", sum}' sales.csv
awk -F',' '{printf "%-10s %-10s %-10s\n", $1, $2, $3}' sales.csv
```

### Exercise Set 3: File Compression

**Exercise 3.1: Archive Operations**
```bash
# Create sample directory structure
mkdir -p backup_test/{documents,images,code}
echo "Document 1" > backup_test/documents/doc1.txt
echo "Document 2" > backup_test/documents/doc2.txt
echo "#!/bin/sh" > backup_test/code/script.sh

# Tasks:
# 1. Create tar.gz archive of backup_test
# 2. List contents of the archive
# 3. Extract to a new location
# 4. Create archive excluding .txt files
# 5. Add a new file to existing archive

# Solutions:
tar -czf backup_test.tar.gz backup_test/
tar -tzf backup_test.tar.gz
mkdir extracted && tar -xzf backup_test.tar.gz -C extracted/
tar -czf backup_no_txt.tar.gz --exclude='*.txt' backup_test/
echo "New file" > newfile.txt
tar -rzf backup_test.tar.gz newfile.txt
```

**Exercise 3.2: File Compression**
```bash
# Create a large text file
seq 1 10000 > numbers.txt

# Tasks:
# 1. Check original file size
# 2. Compress with gzip (keep original)
# 3. Check compressed size
# 4. Decompress to a different name
# 5. Compare compression ratio

# Solutions:
ls -lh numbers.txt
gzip -k numbers.txt
ls -lh numbers.txt.gz
gunzip -c numbers.txt.gz > numbers_restored.txt
echo "Original: $(ls -lh numbers.txt | awk '{print $5}')"
echo "Compressed: $(ls -lh numbers.txt.gz | awk '{print $5}')"
```

### Exercise Set 4: System Monitoring

**Exercise 4.1: Process Management**
```bash
# Tasks:
# 1. List all running processes
# 2. Find processes containing "sh"
# 3. Show top 5 memory-consuming processes
# 4. Create a background process and monitor it
# 5. Kill the background process

# Solutions:
ps aux
ps aux | grep sh
ps aux | sort -k4 -rn | head -5
sleep 300 &  # Creates background process
jobs
kill %1  # Kill the background job
```

**Exercise 4.2: Disk Space Analysis**
```bash
# Tasks:
# 1. Check disk space on all filesystems
# 2. Find size of current directory
# 3. List top 5 largest directories in /data
# 4. Find files larger than 1MB
# 5. Calculate total size of all .txt files

# Solutions:
df -h
du -sh .
du -h /data 2>/dev/null | sort -rh | head -5
find . -type f -size +1M -ls
find . -name "*.txt" -exec du -ch {} + | tail -1
```

### Exercise Set 5: Network Operations

**Exercise 5.1: Basic Networking**
```bash
# Tasks:
# 1. Check network interfaces
# 2. Ping google.com 4 times
# 3. Look up IP address of example.com
# 4. Show active network connections
# 5. Test if port 80 is open on google.com

# Solutions:
ifconfig
ping -c 4 google.com
nslookup example.com
netstat -tuln
nc -zv google.com 80
```

**Exercise 5.2: File Download**
```bash
# Tasks:
# 1. Download a file from the internet
# 2. Download with a custom name
# 3. Resume an interrupted download
# 4. Download and save to specific directory

# Solutions (examples):
wget https://example.com/file.txt
wget -O myfile.txt https://example.com/file.txt
wget -c https://example.com/largefile.zip
wget -P ~/downloads/ https://example.com/file.txt
```

---

## Custom Useful Scripts

### Script 1: System Health Check
```bash
#!/bin/sh
# system_health.sh - Quick system health overview

cat > ~/system_health.sh << 'SCRIPT'
#!/bin/sh

echo "===== SYSTEM HEALTH CHECK ====="
echo ""

echo "=== Date & Time ==="
date
echo ""

echo "=== System Uptime ==="
uptime
echo ""

echo "=== Disk Usage ==="
df -h | grep -v tmpfs
echo ""

echo "=== Memory Usage ==="
free -h
echo ""

echo "=== Top 5 Processes by CPU ==="
ps aux | sort -k3 -rn | head -6
echo ""

echo "=== Top 5 Processes by Memory ==="
ps aux | sort -k4 -rn | head -6
echo ""

echo "=== Network Interfaces ==="
ifconfig | grep -E '^[a-z]|inet '
echo ""

echo "===== END OF REPORT ====="
SCRIPT

chmod +x ~/system_health.sh
```

**Usage:**
```bash
./system_health.sh
# Or save to file:
./system_health.sh > health_report.txt
```

### Script 2: Automated Backup
```bash
#!/bin/sh
# auto_backup.sh - Backup directories with timestamp

cat > ~/auto_backup.sh << 'SCRIPT'
#!/bin/sh

# Configuration
SOURCE_DIR="$1"
BACKUP_DIR="$HOME/backups"
DATE=$(date +%Y%m%d_%H%M%S)

# Check if source directory provided
if [ -z "$SOURCE_DIR" ]; then
    echo "Usage: $0 <source_directory>"
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create backup filename
BACKUP_NAME="backup_$(basename "$SOURCE_DIR")_${DATE}.tar.gz"

# Perform backup
echo "Backing up $SOURCE_DIR..."
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"

# Check if successful
if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_DIR/$BACKUP_NAME"
    echo "Size: $(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)"
else
    echo "Backup failed!"
    exit 1
fi

# Optional: Keep only last 5 backups
cd "$BACKUP_DIR"
ls -t backup_$(basename "$SOURCE_DIR")_*.tar.gz | tail -n +6 | xargs rm -f 2>/dev/null

echo "Cleanup complete. Latest 5 backups retained."
SCRIPT

chmod +x ~/auto_backup.sh
```

**Usage:**
```bash
./auto_backup.sh /path/to/directory
```

### Script 3: Log File Analyzer
```bash
#!/bin/sh
# log_analyzer.sh - Analyze log files for errors and patterns

cat > ~/log_analyzer.sh << 'SCRIPT'
#!/bin/sh

LOG_FILE="$1"

if [ -z "$LOG_FILE" ] || [ ! -f "$LOG_FILE" ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

echo "===== LOG ANALYSIS: $LOG_FILE ====="
echo ""

echo "=== File Information ==="
echo "Size: $(du -h "$LOG_FILE" | cut -f1)"
echo "Lines: $(wc -l < "$LOG_FILE")"
echo "Last Modified: $(ls -l "$LOG_FILE" | awk '{print $6, $7, $8}')"
echo ""

echo "=== Error Summary ==="
echo "ERROR count: $(grep -c "ERROR" "$LOG_FILE" 2>/dev/null || echo 0)"
echo "WARNING count: $(grep -c "WARNING" "$LOG_FILE" 2>/dev/null || echo 0)"
echo "CRITICAL count: $(grep -c "CRITICAL" "$LOG_FILE" 2>/dev/null || echo 0)"
echo ""

echo "=== Recent Errors (Last 5) ==="
grep "ERROR" "$LOG_FILE" | tail -5
echo ""

echo "=== Most Frequent Messages ==="
awk '{print $NF}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10
echo ""

echo "=== Time Distribution (by hour) ==="
awk '{print $2}' "$LOG_FILE" | cut -d: -f1 | sort | uniq -c
echo ""

echo "===== END OF ANALYSIS ====="
SCRIPT

chmod +x ~/log_analyzer.sh
```

**Usage:**
```bash
./log_analyzer.sh /path/to/logfile.log
```

### Script 4: File Cleanup Utility
```bash
#!/bin/sh
# cleanup.sh - Clean old files and free space

cat > ~/cleanup.sh << 'SCRIPT'
#!/bin/sh

DAYS_OLD="${1:-7}"  # Default 7 days
TARGET_DIR="${2:-.}"  # Default current directory

echo "===== CLEANUP UTILITY ====="
echo "Target: $TARGET_DIR"
echo "Removing files older than: $DAYS_OLD days"
echo ""

# Show what will be deleted (dry run)
echo "Files to be removed:"
find "$TARGET_DIR" -type f -mtime +$DAYS_OLD -ls

echo ""
read -p "Proceed with deletion? (y/n): " CONFIRM

if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
    # Delete old files
    DELETED=$(find "$TARGET_DIR" -type f -mtime +$DAYS_OLD -delete -print | wc -l)
    echo "Deleted $DELETED files"
    
    # Remove empty directories
    find "$TARGET_DIR" -type d -empty -delete 2>/dev/null
    echo "Empty directories removed"
    
    echo ""
    echo "Cleanup complete!"
    echo "Current disk usage:"
    df -h "$TARGET_DIR"
else
    echo "Cleanup cancelled"
fi
SCRIPT

chmod +x ~/cleanup.sh
```

**Usage:**
```bash
./cleanup.sh 7 /path/to/directory
# Or use defaults (7 days, current directory)
./cleanup.sh
```

### Script 5: Network Connection Monitor
```bash
#!/bin/sh
# netmon.sh - Monitor network connectivity

cat > ~/netmon.sh << 'SCRIPT'
#!/bin/sh

HOST="${1:-8.8.8.8}"  # Default to Google DNS
INTERVAL="${2:-5}"     # Default 5 seconds
LOG_FILE="$HOME/netmon.log"

echo "Monitoring connection to $HOST every $INTERVAL seconds"
echo "Press Ctrl+C to stop"
echo "Logging to: $LOG_FILE"
echo ""

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    if ping -c 1 -W 2 "$HOST" > /dev/null 2>&1; then
        STATUS="UP"
        echo "[$TIMESTAMP] $HOST is reachable"
        echo "[$TIMESTAMP] $HOST - $STATUS" >> "$LOG_FILE"
    else
        STATUS="DOWN"
        echo "[$TIMESTAMP] $HOST is UNREACHABLE!"
        echo "[$TIMESTAMP] $HOST - $STATUS" >> "$LOG_FILE"
        
        # Optional: Send alert (customize as needed)
        echo "Alert: Network to $HOST is down!" >> "$LOG_FILE"
    fi
    
    sleep "$INTERVAL"
done
SCRIPT

chmod +x ~/netmon.sh
```

**Usage:**
```bash
./netmon.sh google.com 10  # Monitor google.com every 10 seconds
./netmon.sh                 # Use defaults
```

### Script 6: Quick File Search
```bash
#!/bin/sh
# qfind.sh - Quick file finder with smart search

cat > ~/qfind.sh << 'SCRIPT'
#!/bin/sh

SEARCH_TERM="$1"
SEARCH_PATH="${2:-.}"

if [ -z "$SEARCH_TERM" ]; then
    echo "Usage: $0 <search_term> [path]"
    exit 1
fi

echo "Searching for: $SEARCH_TERM in $SEARCH_PATH"
echo ""

echo "=== Files by name ==="
find "$SEARCH_PATH" -type f -name "*$SEARCH_TERM*" 2>/dev/null
echo ""

echo "=== Files containing text ==="
grep -r "$SEARCH_TERM" "$SEARCH_PATH" 2>/dev/null | cut -d: -f1 | sort -u
echo ""

echo "=== Directories ==="
find "$SEARCH_PATH" -type d -name "*$SEARCH_TERM*" 2>/dev/null
SCRIPT

chmod +x ~/qfind.sh
```

**Usage:**
```bash
./qfind.sh myfile          # Search in current directory
./qfind.sh myfile /data    # Search in specific directory
```

---

## Common Problems & Solutions

### Problem 1: "Disk Space Full"

**Symptoms:**
- Cannot create new files
- Applications failing
- System slow

**Diagnosis:**
```bash
# Check disk usage
df -h

# Find largest directories
du -h / 2>/dev/null | sort -rh | head -20

# Find largest files
find / -type f -size +100M -exec ls -lh {} \; 2>/dev/null
```

**Solutions:**
```bash
# Remove old log files
find /var/log -name "*.log" -mtime +30 -delete

# Clean temporary files
rm -rf /tmp/*

# Remove package caches (if applicable)
apt clean 2>/dev/null || pkg clean 2>/dev/null

# Compress old files
find . -name "*.log" -mtime +7 -exec gzip {} \;
```

### Problem 2: "Cannot Execute Script"

**Symptoms:**
- Permission denied error
- Script won't run

**Diagnosis:**
```bash
# Check file permissions
ls -l script.sh

# Check file type
file script.sh
```

**Solutions:**
```bash
# Add execute permission
chmod +x script.sh

# Verify shebang line
head -1 script.sh  # Should be #!/bin/sh or similar

# Run with explicit shell
sh script.sh
```

### Problem 3: "Process Using Too Much CPU/Memory"

**Diagnosis:**
```bash
# Find CPU-intensive processes
ps aux | sort -k3 -rn | head -10

# Find memory-intensive processes
ps aux | sort -k4 -rn | head -10

# Monitor in real-time
top
```

**Solutions:**
```bash
# Kill specific process
kill <PID>

# Force kill if needed
kill -9 <PID>

# Kill all instances of a process
killall process_name

# Run process with lower priority
nice -n 19 command
```

### Problem 4: "File Accidentally Deleted"

**Prevention (Create backup script):**
```bash
# Instead of rm, create safe-rm alias
alias rm='rm -i'  # Interactive mode

# Or create a trash directory
mkdir -p ~/.trash
alias del='mv --target-directory=$HOME/.trash'
```

**Recovery (if possible):**
```bash
# Check if file was moved to trash
ls ~/.trash

# Restore from backup
cp ~/backups/latest_backup.tar.gz .
tar -xzf latest_backup.tar.gz
```

### Problem 5: "Network Connection Issues"

**Diagnosis:**
```bash
# Check interface status
ifconfig

# Test connectivity
ping -c 4 8.8.8.8

# Check DNS
nslookup google.com

# Check routing
route -n
```

**Solutions:**
```bash
# Restart network interface
ifconfig wlan0 down
ifconfig wlan0 up

# Test different DNS
nslookup google.com 8.8.8.8

# Check if specific port is blocked
nc -zv google.com 80
```

---

## Deep Dive Tutorials

### Tutorial 1: Mastering Text Processing Pipelines

**Concept:** Chaining commands to process data efficiently

**Example Problem:** Analyze a web server access log

```bash
# Sample log format: IP - - [date] "request" status size

# Step 1: Extract unique IP addresses
cat access.log | awk '{print $1}' | sort -u

# Step 2: Count requests per IP
cat access.log | awk '{print $1}' | sort | uniq -c | sort -rn

# Step 3: Find top 10 IPs
cat access.log | awk '{print $1}' | sort | uniq -c | sort -rn | head -10

# Step 4: Extract 404 errors
grep ' 404 ' access.log | awk '{print $7}' | sort | uniq -c

# Step 5: Create summary report
cat access.log | awk '
{
    ip[$1]++
    status[$9]++
}
END {
    print "=== Top 5 IPs ==="
    # Note: This is simplified; full sorting would need more code
    for (i in ip) print ip[i], i
    
    print "\n=== Status Codes ==="
    for (s in status) print s, status[s]
}'
```

**Practice Exercise:**
```bash
# Create sample log
cat > access.log << 'EOF'
192.168.1.100 - - [29/Oct/2025:10:00:00] "GET /index.html" 200 1234
192.168.1.101 - - [29/Oct/2025:10:01:00] "GET /about.html" 200 5678
192.168.1.100 - - [29/Oct/2025:10:02:00] "GET /missing.html" 404 0
192.168.1.102 - - [29/Oct/2025:10:03:00] "POST /api/data" 500 100
192.168.1.101 - - [29/Oct/2025:10:04:00] "GET /index.html" 200 1234
EOF

# Now run the analysis commands above
```

### Tutorial 2: Advanced Find Techniques

**Find files modified in the last 24 hours:**
```bash
find /path -type f -mtime 0
```

**Find files by multiple criteria:**
```bash
# Files larger than 10MB modified in last 7 days
find /path -type f -size +10M -mtime -7

# .txt or .log files
find /path -type f \( -name "*.txt" -o -name "*.log" \)

# Files owned by specific user
find /path -type f -user username
```

**Execute complex operations:**
```bash
# Find and compress old logs
find /var/log -name "*.log" -mtime +30 -exec gzip {} \;

# Find and move files to archive
find /source -name "*.bak" -exec mv {} /archive/ \;

# Find and show detailed info
find /path -name "*.conf" -exec ls -lh {} \;
```

**Using find with xargs for efficiency:**
```bash
# Delete many files efficiently
find /path -name "*.tmp" | xargs rm

# Process files in batches
find /path -name "*.txt" | xargs -n 5 grep "pattern"

# Handle filenames with spaces
find /path -name "*.txt" -print0 | xargs -0 grep "pattern"
```

### Tutorial 3: sed Power User Guide

**Basic substitutions:**
```bash
# Replace first occurrence
sed 's/old/new/' file.txt

# Replace all occurrences
sed 's/old/new/g' file.txt

# Replace only on lines matching pattern
sed '/pattern/s/old/new/g' file.txt
```

**Advanced substitutions:**
```bash
# Use different delimiter
sed 's|/old/path|/new/path|g' file.txt

# Case-insensitive replace
sed 's/old/new/gi' file.txt

# Backreferences
echo "Name: John" | sed 's/Name: \(.*\)/Hello, \1!/'
# Output: Hello, John!
```

**Line manipulation:**
```bash
# Delete lines
sed '5d' file.txt              # Delete line 5
sed '/pattern/d' file.txt      # Delete lines matching pattern
sed '1,5d' file.txt            # Delete lines 1-5

# Insert and append
sed '3i\New line' file.txt     # Insert before line 3
sed '3a\New line' file.txt     # Append after line 3
sed '/pattern/a\New' file.txt  # Append after matching line

# Change entire line
sed '/pattern/c\Replacement' file.txt
```

**Multiple operations:**
```bash
# Chain multiple commands
sed -e 's/old/new/g' -e 's/foo/bar/g' file.txt

# Use sed script
cat > script.sed << 'EOF'
s/old/new/g
s/foo/bar/g
/pattern/d
EOF
sed -f script.sed file.txt
```

### Tutorial 4: awk Data Processing

**Basic field processing:**
```bash
# Print specific fields
awk '{print $1, $3}' file.txt

# Use different delimiter
awk -F':' '{print $1}' /etc/passwd

# Process CSV
awk -F',' '{print $1, $2}' data.csv
```

**Conditional processing:**
```bash
# Print lines where field meets condition
awk '$3 > 100 {print}' file.txt

# Multiple conditions
awk '$3 > 100 && $4 < 200 {print $1}' file.txt

# Pattern matching
awk '/ERROR/ {print $0}' logfile
awk '$2 ~ /pattern/ {print}' file.txt
```

**Calculations and statistics:**
```bash
# Sum a column
awk '{sum += $2} END {print sum}' file.txt

# Average
awk '{sum += $1; count++} END {print sum/count}' file.txt

# Min and Max
awk 'NR==1 {min=max=$1}
     $1>max {max=$1}
     $1<min {min=$1}
     END {print "Min:", min, "Max:", max}' file.txt

# Count occurrences
awk '{count[$1]++} END {for (item in count) print item, count[item]}' file.txt
```

**Formatted output:**
```bash
# Printf formatting
awk '{printf "%-10s %5.2f\n", $1, $2}' file.txt

# Create reports
awk 'BEGIN {print "Name", "Score"}
     {printf "%-10s %5d\n", $1, $2}
     END {print "Total records:", NR}' file.txt
```

---

## Command Testing Lab

### Safe Testing Environment Setup

```bash
# Create a test directory
mkdir -p ~/busybox_lab
cd ~/busybox_lab

# Create sample files for testing
cat > sample1.txt << 'EOF'
Line 1: Hello World
Line 2: BusyBox Tutorial
Line 3: Learning Commands
Line 4: Practice Makes Perfect
Line 5: Keep Learning
EOF

cat > sample2.txt << 'EOF'
Data 1: 100
Data 2: 250
Data 3: 175
Data 4: 300
Data 5: 425
EOF

cat > sample.csv << 'EOF'
Name,Age,City
John,30,NYC
Jane,25,LA
Bob,35,Chicago
Alice,28,Boston
EOF

# Create test directory structure
mkdir -p test/{dir1,dir2,dir3}
touch test/dir1/file1.txt
touch test/dir2/file2.log
touch test/dir3/file3.sh

echo "Test environment ready in ~/busybox_lab"
```

### Interactive Test Commands

Now try these commands in your test environment:

```bash
# Text processing tests
cat sample1.txt
grep "Learning" sample1.txt
sed 's/Line/Row/g' sample1.txt
awk '{print NR, $0}' sample1.txt

# File operation tests
cp sample1.txt sample1_backup.txt
mv sample1_backup.txt backup/
ls -lR

# Find tests
find test -type f
find test -name "*.txt"
find test -type f -exec ls -lh {} \;

# Text analysis
wc -l sample1.txt
wc -w sample1.txt
sort sample1.txt
uniq sample1.txt

# CSV processing
cat sample.csv | column -t -s ','
awk -F',' 'NR>1 {print $1, $2}' sample.csv
```

---

## Troubleshooting Guide

### Issue: "Command not found"

**Check:**
```bash
# Is busybox installed?
busybox --list

# Is the command available?
which command_name

# Try with busybox prefix
busybox command_name
```

### Issue: "Permission denied"

**Check:**
```bash
# File permissions
ls -l filename

# Directory permissions
ls -ld directory

# Your user
whoami
id
```

**Fix:**
```bash
# Make executable
chmod +x filename

# Change owner (if you have permission)
chown user:group filename
```

### Issue: "No space left on device"

**Check:**
```bash
# Disk usage
df -h

# Large files
du -h . | sort -rh | head -20
```

**Fix:**
```bash
# Remove unnecessary files
rm -f unnecessary_file

# Clean temporary files
rm -rf /tmp/*

# Compress old files
gzip large_file.txt
```

### Issue: "Text file busy"

**Cause:** File is being executed or used by another process

**Fix:**
```bash
# Find process using the file
fuser filename

# Or
lsof filename

# Kill the process
kill <PID>
```

### Issue: "Broken pipe"

**Cause:** Usually happens when piping to a command that exits early (like `head`)

**Not a problem:** This is normal behavior
```bash
# This is fine:
cat large_file.txt | head -10
# (Broken pipe error is expected and harmless)
```

---

## Quick Reference Commands

### Most Used Combinations

```bash
# Find large files
find / -type f -size +100M 2>/dev/null | xargs ls -lh

# Count files by extension
find . -type f | sed 's/.*\.//' | sort | uniq -c

# Monitor log in real-time
tail -f logfile.log | grep --line-buffered "ERROR"

# Quick backup
tar -czf backup-$(date +%F).tar.gz directory/

# Find and replace in multiple files
find . -name "*.txt" -exec sed -i 's/old/new/g' {} \;

# Directory size sorted
du -h --max-depth=1 | sort -h

# Process by memory
ps aux | sort -k4 -rn | head -10

# Network listening ports
netstat -tuln | grep LISTEN
```

---

## Next Steps

1. **Complete all exercises** in order
2. **Install the custom scripts** and use them daily
3. **Practice command combinations** from the cheat sheet
4. **Create your own scripts** for repetitive tasks
5. **Review troubleshooting guide** when issues arise

## Tips for Learning

- **Start simple:** Master basic commands before combining them
- **Type, don't copy:** Muscle memory helps learning
- **Break commands:** Understand each part of a pipeline
- **Read errors:** Error messages contain helpful information
- **Experiment safely:** Use test directories for practice
- **Keep notes:** Document your most-used commands

---

**Remember:** The key to mastering BusyBox is consistent practice. Try to use these commands in your daily workflow!
