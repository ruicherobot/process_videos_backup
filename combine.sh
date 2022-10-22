#!/bin/bash

start=$(date +%s.%N)


echo Please enter year in YYYY format for the video compression
read year
echo Please enter month in MM format
read month
echo Please enter date in DD format
read date
echo Please enter timestamp in HHMM in 24HR format, separated by spaces
read -a timelist
videodate="$year$month$date"
echo "videodate is $videodate"

for timestamp in ${timelist[@]}
do
    files=""
    for video in /media/data/timelapse/timelapsevideo/*
    do
        if [[ "$video" == *"$videodate-$timestamp"* ]];then
            echo "video $video is added to file list"
            files+="-i $video "
        fi
    done
    itshour=${timestamp:0:2}
    echo "list complete and now processing for aggerated video at $timestamp"
    ffmpeg $files \
    -filter_complex \
    " \
    [0:v]scale=400:800[v0];\
    [1:v]scale=400:800[v1];\
    [2:v]scale=400:800[v2];\
    [3:v]scale=400:800[v3];\
    [4:v]scale=400:800[v4];\
    [5:v]scale=400:800[v5];\
    [6:v]scale=1600:800[v6];\
    [v0][v6]hstack=inputs=2[top];\
    [v5][v4][v3][v2][v1]hstack=inputs=5[bottom];\
    [top][bottom]vstack=inputs=2[v] \
    " \
    -map "[v]" /media/data/timelapse/$videodate/$itshour/stacktimelapse$videodate$timestamp.mp4
    stlcount=$(($stlcount + 1))
done
echo "~~~~~~~~~~~~~Stacked $stlcount Timelapse Videos This Time~~~~~~~~~~~~~~~~"
stlcount=0
duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`
echo "Script Execution Time: $execution_time"