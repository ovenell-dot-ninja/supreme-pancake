# stop all docker containers
docker stop $(docker ps -a -q)

# start all docker containers
docker start $(docker ps -a -q)

# determine whats running on a given port
sudo netstat -tulpn | grep :443

# determine the owner of a running process
ps aux | grep 3813

# disable a service from starting at boot
systemctl disable nginx

# find the PWD of a running process
ls -l /proc/3813/cwd

# show all screen sessions on a machine (all users)
ls -laR /var/run/screen/

# find and kill a process
ps aux | grep lighttpd
kill 3486

# Displays the quantity of connections to port 80 on a per IP basis
clear;while x=0; do clear;date;echo "";echo "  [Count] | [IP ADDR]";echo "-------------------";netstat -np|grep :80|grep -v LISTEN|awk '{print $5}'|cut -d: -f1|uniq -c; sleep 5;done

# Convert directory of videos to MP4 in parallel
for INPUT in *.avi ; do echo "${INPUT%.avi}" ; done | xargs -i -P9  HandBrakeCLI -i "{}".avi -o "{}".mp4

# Rename all items in a directory to lower case
for i in *; do mv "$i" "${i,,}"; done

# List IP addresses connected to your server on port 80
netstat -tn 2>/dev/null | grep :80 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head

# get your external address via dig
dig +short myip.opendns.com @resolver1.opendns.com

# Remove offending key from known_hosts file with one swift move
ssh-keygen -R <hostname>

# Kill a process running on port 8080
lsof -i :8080 | awk '{l=$2} END {print l}' | xargs kill

# Output an arbitrary number of open TCP or UDP ports in an arbitrary range
comm -23 <(seq "$FROM" "$TO") <(ss -tan | awk '{print $4}' | cut -d':' -f2 | grep "[0-9]\{1,5\}" | sort | uniq) | shuf | head -n "$HOWMANY"

# Retrieve dropped connections from firewalld journaling
sudo journalctl -b | grep -o "PROTO=.*" | sed -r 's/(PROTO|SPT|DPT|LEN)=//g' | awk '{print $1, $3}' | sort | uniq -c

# create a set of folders
mkdir -p /var/spool/gammu/{inbox,outbox,sent,error}

# Generate a sequence of numbers
for ((i=1; i<=10; ++i)); do echo $i; done

# generate random texts
tr -dc a-z1-4 </dev/urandom | tr 1-2 ' \n' | awk 'length==0 || length>50' | tr 3-4 ' ' | sed 's/^ *//' | cat -s | fmt

# Dump network traffic with tcpdump to file with time-stamp in its filename
date +"%Y-%m-%d_%H-%M-%Z" | xargs -I {} bash -c "sudo tcpdump -nq -s 0 -i eth0 -w ./dump-{}.pcap"

# Convert a music file (mp3) to a mp4 video with a static image
ffmpeg -loop_input -i cover.jpg -i soundtrack.mp3 -shortest -acodec copy output_video.mp4

# Remove files and directories whose name is a timestamp older than a certain time
ls | grep '....-..-..-......' | xargs -I {} bash -c "[[ x{} < x$(date -d '3 days ago' +%Y-%m-%d-%H%M%S) ]] && rm -rfv {}"

# Unhide all hidden files in the current directory.
find . -maxdepth 1 -type f -name '\.*' | sed -e 's,^\./\.,,' | sort | xargs -iname mv .name name

# Create a thumbnail from the first page of a PDF file
convert -thumbnail x80 file.pdf[0] thumb.png

# Create a visual report of the contents of a usb drive
find /path/to/drive -type f -exec file -b '{}' \; -printf '%s\n' | awk -F , 'NR%2 {i=$1} NR%2==0 {a[i]+=$1} END {for (i in a) printf("%12u %s\n",a[i],i)}' | sort -nr

# Send HTTP POST to a website with a file input field
curl -L -v -F "value=@myfile" "http://domain.tld/whatever.php"

# Rename all files in the current directory by capitalizing the first letter of every word in the filenames
ls | perl -ne 'chomp; $f=$_; tr/A-Z/a-z/; s/(?<![.'"'"'])\b\w/\u$&/g; print qq{mv "$f" "$_"\n}'

# Remove spaces recursively from all subdirectories of a directory
find /path/to/dir -type d | tac | while read LINE; do target=$(dirname "$LINE")/$(basename "$LINE" | tr -d ' '); echo mv "$LINE" "$target"; done

# Generate a random 32 characters password
tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></";.,[]=-' < /dev/urandom | fold -w 32 | head -n 1

# Inspect the HTTP headers of a website
curl -I amazon.com

# Random 6-digit number
python -c 'import random; print(random.randint(0,1000000-1))'

# List the content of a GitHub repository without cloning it
svn ls https://github.com/user/repo/trunk/some/path

# Parse nginx statistics output
i=$(curl -s server/nginx_stats); IFS=$'\n'; i=($i); a=${i[0]/Active connections: } && a=${a/ }; r=${i[2]# [0-9]* [0-9]* }; echo "Active: $a, requests: $r"

# Find recent logs that contain the string "Exception"
find . -name '*.log' -mtime -2 -exec grep -Hc Exception {} \; | grep -v :0$

# Get average CPU temperature from all cores.
$ __=`sensors | grep Core` && echo \(`echo $__ | sed 's/.*+\(.*\).C\(\s\)\+(.*/\1/g' | tr "\n" "+" | head -c-1`\)\/`echo $__ | wc -l` | bc && unset __

# Create a transparent image of given dimensions
convert -size 100x100 xc:none transparency.png

# print a random cat
wget -O - http://placekitten.com/$[500 + RANDOM % 500] | lp

# Find all of the distinct file extensions in a folder
find . -type f | perl -ne 'print $1 if m/\.([^.\/]+)$/' | sort -u

# Get only the latest version of a file from across mutiple directories.
find . -name 'filename' | xargs -r ls -tc | head -n1

# Replace the header of all files found.
find . -type f -name '*.html' -exec sed -i -e '1r common_header' -e '1,/STRING/d' {} \;

# Recording SSH sessions
ssh -l USER HOST | tee -a /path/to/file

# Record audio from microphone or sound input from the console
sox -t ossdsp -w -s -r 44100 -c 2 /dev/dsp -t raw - | lame -x -m s - File.mp3

# Use vim to pretty-print code with syntax highlighting
vim +'hardcopy > output.ps' +q style.css 

# Remove carriage return '\r' character in many files, without looping and intermediary files
vi +'bufdo set ff=unix' +'bufdo %s/^M$//' +q file1 file2 file3

# Sort and remove duplicate lines in a file in one step without intermediary files
vi +'%!sort | uniq' +wq file.txt

# find in files recursively
grep -rn 'nameserver' /etc 2>/dev/null

# View a file with line numbers
cat -n /path/to/file | less

# Test your hard drive speed
time (dd if=/dev/zero of=zerofile bs=1M count=500;sync);rm zerofile

# Concatenate two or more movie files into one using mencoder
mencoder cd1.avi cd2.avi -o movie.avi -ovc copy -oac copy

# How to find all hard links to a file
find /home -xdev -samefile file1

# Recursively remove all empty sub-directories from a directory tree
find . -depth  -type d  -empty -exec rmdir {} \;

# Group count sort a log file
A=$(FILE=/var/log/myfile.log; cat $FILE | perl -p -e 's/.*,([A-Z]+)[\:\+].*/$1/g' | sort -u | while read LINE; do grep "$LINE" $FILE | wc -l | perl -p -e 's/[^0-9]+//g'; echo -e "\t$LINE"; done;);echo "$A"|sort -nr

# Find all the unique 4-letter words in a text
cat ipsum.txt | perl -ne 'print map("$_\n", m/\w+/g);' | tr A-Z a-z | sort | uniq | awk 'length($1) == 4 {print}'

# Calculate the average execution time (of short running scripts) with awk
for i in {1..10}; do time some_script.sh; done 2>&1 | grep ^real | sed -e s/.*m// | awk '{sum += $1} END {print sum / NR}'

# Get a free shell account on a community server
sh <(curl hashbang.sh | gpg)

# Run a local shell script on a remote server without copying it there
ssh user@server bash < /path/to/local/script.sh

# Print the list of your Git commits this month
git log --since='last month' --author="$(git config user.name)" --oneline

# Store the output of find in an array
mapfile -d $'\0' arr < <(find /path/to -print0)

# Dump all AWS IAM users/roles to a Terraform file for editing / reusing in another environment
echo iamg iamgm iamgp iamip iamp iampa iamr iamrp iamu iamup | AWS_PROFILE=myprofile xargs -n1  terraforming

# 

