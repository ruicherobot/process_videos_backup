#!/bin/bash

echo Please enter year and month and date in YYYYMMDD format to create folders for stacked videos
read videodate
echo Please enter hours in HH in 24HR format, separated by spaces
read -a timelist
mkdir /media/data/timelapse/$videodate
for timestamp in ${timelist[@]}
do
    mkdir /media/data/timelapse/$videodate/$timestamp
done

echo "Folders Created! Ready to accept videos!"
