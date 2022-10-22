#!/bin/bash

start=$(date +%s.%N)

read dateinfo

mon=${dateinfo:4:3}
if [[ "$mon" == *"Jan"* ]];then
    month="01"
elif [[ "$mon" == *"Feb"* ]];then
    month="02"
elif [[ "$mon" == *"Mar"* ]];then
    month="03"
elif [[ "$mon" == *"Apr"* ]];then
    month="04"
elif [[ "$mon" == *"May"* ]];then
    month="05"
elif [[ "$mon" == *"Jun"* ]];then
    month="06"
elif [[ "$mon" == *"Jul"* ]];then
    month="07"
elif [[ "$mon" == *"Aug"* ]];then
    month="08"
elif [[ "$mon" == *"Sep"* ]];then
    month="09"
elif [[ "$mon" == *"Oct"* ]];then
    month="10"
elif [[ "$mon" == *"Nov"* ]];then
    month="11"
elif [[ "$mon" == *"Dec"* ]];then
    month="12"
fi
datepre=${dateinfo:8:1}
datepost=${dateinfo:9:1}
if [[ "$datepre" == *" "* ]];then
    date="0$datepost"
else 
    date=${dateinfo:8:2}
fi
currentTime=${dateinfo:11:8}
year=${dateinfo:24:4}
videodate="$year$month$date"

sleep 5

timelist="0000 0015 0030 0045 0100 0115 0130 0145 0200 0215 0230 0245 0300 0315 0330 0345 0400 0415 0430 0445 0500 0515 0530 0545 0600 0615 0630 0645 0700 0715 0730 0745 0800 0815 0830 0845 0900 0915 0930 0945 1000 1015 1030 1045 1100 1115 1130 1145"

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
                ffmpeg -i $video -r 10 -vf crop=in_w*8.0/9.0:in_h:in_w/9.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam002"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*8.0/9.0:in_h:in_w/9.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam003"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*8.0/9.0:in_h:in_w/9.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam004"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*8.0/9.0:in_h:in_w/9.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam005"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*8.0/9.0:in_h:in_w/9.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            else
                ffmpeg -i $video -r 10 -vf "setpts=1/30*PTS,pad=in_w*1.41:in_h+10:0:5:white,drawtext=text='$year-$month-$date':x=(w)*0.85-(text_w)/2:y=(h)*1/5:fontsize=50:fontcolor=red,drawtext=text='$hour-$minute to $nexthour-$nextminute':x=(w)*0.85-(text_w)/2:y=(h)*2/5:fontsize=60:fontcolor=yellow,drawtext=text=' Self Check Out':x=(w)*0.85-(text_w)/2:y=(h)*3/5:fontsize=60:fontcolor=blue,drawtext=text=' 1 2 3 4 5 ':x=(w)*0.85-(text_w)/2:y=(h)*4/5:fontsize=60:fontcolor=green" /media/data/timelapse/timelapsevideo/timelapse$name.mp4
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
    [5:v]scale=2000:800[top];\
    [v0][v1][v2][v3][v4]hstack=inputs=5[bottom];\
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
