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

timelist="1200 1215 1230 1245 1300 1315 1330 1345 1400 1415 1430 1445 1500 1515 1530 1545 1600 1615 1630 1645 1700 1715 1730 1745 1800 1815 1830 1845 1900 1915 1930 1945 2000 2015 2030 2045 2100 2115 2130 2145 2200 2215 2230 2245 2300 2315 2330 2345"

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
	    elif [[ "$video" == *"cam006"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*8.0/9.0:in_h:in_w/9.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam007"* ]];then
                ffmpeg -i $video -r 10 -vf crop=in_w*8.0/9.0:in_h:in_w/9.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
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