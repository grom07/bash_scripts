#!/bin/bash
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
gpuTemp=$(/opt/vc/bin/vcgencmd measure_temp | grep -E -o '[0-9]{,3}\.[0-9]{,3}')

# Function to write the temperature into the log
function writeToLog() {
	# The direction of the file
	# you can put here another route
	file1="/home/pi/temperature/cpu_gpu_temp.log"
	file2="/home/pi/temperature/master.log"

	# Check if the file exists
	if [ ! -f "$file1" ] ; then
         	# if not create the file
        	touch "$file1"
    fi

	if [[ $(sed '1q;d' "$file1" ) != "Date,Time,CPU temp (C°),GPU temp (C°)" ]]; then 
		echo "Date,Time,CPU temp (C°),GPU temp (C°)" > "$file1"
	fi

	echo "$1" >> "$file1"
}

# Save the value
writeToLog "$(date "+%d-%m-%Y"),$(date "+%H:%M"),$cpuTemp1.$cpuTempM,$gpuTemp"

# Check the temperature
if [ "$cpuTemp1" -gt  "90" ]
        then writeToLog "Shutdown.......;"; `shutdown -h now`
fi

