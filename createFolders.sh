#!/bin/bash

echo "Please enter year and month and date in MMDD format to create folders for stacked videos in [2022]"
read -a datelist
year="2022"
hourlist="00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23"

for videodate in ${datelist[@]}
do
    mkdir /media/data/timelapse/$year$videodate
    for timestamp in ${hourlist[@]}
    do
        mkdir /media/data/timelapse/$year$videodate/$timestamp
    done
    echo "Folders Created! Ready to accept videos!"
done
