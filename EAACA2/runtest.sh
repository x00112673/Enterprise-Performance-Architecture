#!/bin/bash
#EAA CA2
#James O'Reilly
#X00112673

#prints header to file everytime runtest.sh is executed

printf "%-8s %-8s %-8s" "CN" "N" "IDLE" > results.dat

for i in {1..50}
do

# Sets the loadtest file to exectue only on cpu 0
# using taskset. The use of $i sets a different parameter
# for the loadtest in the range 1 - 50 each time it is executed
# the use of '&' allows a command to be exectued concurrently 

timeout 10 taskset -c 0 ./loadtest $i &


# stores the output of command in idle variable
# mpstat gives a report of processor 0 
# displaying 10 reports of stats at 1 second intervals
# including an average stat
# awk searches for 'Average' within each report
# and retrieves the 12th value in that row which is idle

idle="$(mpstat -P 0 1 10 | awk '/Average/ {print $12}')"


# stores the output of command in CN variable
# counts number of complete transactions for each loadtest

Co="$(cat synthetic.dat | wc -l)"

# writes the values of Co i & idle to results.dat

printf "\n%-8s %-8s %-8s" "${Co}" $i "${idle}" >> results.dat

done

