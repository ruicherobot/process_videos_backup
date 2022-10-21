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
    echo "time stamp is $timestamp"
    echo "Starting process timelapse video at $timestamp in folder $year-$month-$date folder"
    for video in /media/data/$year-$month-$date/*
    do
        if [[ "$video" == *"$videodate-$timestamp"* ]];then
            file="$(basename -- $video)"
            name="${file%.*}"
            hour=${timestamp:0:2}
            minute=${timestamp:2:2}
            nextminute=$(($minute + 15))
            if [ "$nextminute" == "60" ]
            then
                nextminute=00
                nexthour=$((10#$hour + 1))
                if [ "$(($nexthour / 10))" == "0" ]
                then
                    nexthour="0$nexthour"
                fi
                if [ "$nexthour" == "24" ]
                then
                    nexthour=00
                fi
            else
                nexthour=$hour
            fi
            
            if [[ "$video" == *"cam001"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*1.0/2.0:in_h:in_w*4.38/10.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam002"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*1.0/2.0:in_h:in_w*3.39/10.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam003"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*1.0/2.0:in_h:in_w*3.68/10.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam004"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*1.0/2.0:in_h:in_w*4.5/10.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam005"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*1.0/2.0:in_h:in_w*4.55/10.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam006"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*1.0/2.0:in_h:in_w*4.63/10.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam007"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*1.0/2.0:in_h:in_w*4.65/10.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam008"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*1.0/2.0:in_h:in_w*4.5/10.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam009"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*1.0/2.0:in_h:in_w*4.5/10.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            else
                ffmpeg -i $video -r 10 -vf "setpts=1/30*PTS,pad=in_w*2.0:in_h+10:in_w:5:white,drawtext=text='$year-$month-$date':x=(w)/4-(text_w)/2:y=(h)*1/5:fontsize=50:fontcolor=red,drawtext=text='$hour-$minute to $nexthour-$nextminute':x=(w)/4-(text_w)/2:y=(h)*2/5:fontsize=60:fontcolor=yellow,drawtext=text='   SCO 1 2 3':x=(w)/4-(text_w)/2:y=(h)*3/5:fontsize=60:fontcolor=blue,drawtext=text='4 5 6 7 8 9':x=(w)/4-(text_w)/2:y=(h)*4/5:fontsize=60:fontcolor=green" /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            fi
        fi
    done
    echo "timelapse video at $timestamp is done"
done
stlcount=0

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
    [6:v]scale=400:800[v6];\
    [7:v]scale=400:800[v7];\
    [8:v]scale=400:800[v8];\
    [9:v]scale=1200:800[v9];\
    [v3][v4][v5][v6][v7][v8]hstack=inputs=6[bottom];\
    [v9][v0][v1][v2]hstack=inputs=4[top];\
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
