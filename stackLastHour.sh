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
currentHour=${dateinfo:11:2}
currentMin=${dateinfo:14:2}
currentSec=${dateinfo:17:2}
year=${dateinfo:24:4}
videodate="$year$month$date"

timelist="00 15 30 45"

# ffmpeg -i $video -r 10 -vf crop=in_w*9.0/9.0:in_h:0.0:0,setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4

for timestamp in ${timelist[@]}
do
    for video in /media/data/$year-$month-$date/*
    do
        if [[ "$video" == *"$videodate-$currentHour$timestamp"* ]];then
            file="$(basename -- $video)"
            name="${file%.*}"
            if [[ "$video" == *"cam005"* ]];then
                ffmpeg -i $video -r 12 -crf 27 -vf setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam006"* ]];then
                ffmpeg -i $video -r 12 -crf 27 -vf setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam007"* ]];then
                ffmpeg -i $video -r 12 -crf 27 -vf setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam008"* ]];then
                ffmpeg -i $video -r 12 -crf 27 -vf setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam009"* ]];then
                ffmpeg -i $video -r 12 -crf 27 -vf setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
	    elif [[ "$video" == *"cam010"* ]];then
                ffmpeg -i $video -r 12 -crf 27 -vf setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            elif [[ "$video" == *"cam011"* ]];then
                ffmpeg -i $video -r 12 -crf 27 -vf setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
	    elif [[ "$video" == *"cam012"* ]];then
                ffmpeg -i $video -r 12 -crf 27 -vf setpts=1/30*PTS,pad=in_w+10:in_h+10:5:5:purple /media/data/timelapse/timelapsevideo/timelapse$name.mp4
            fi
        fi
    done
    echo "timelapse video at $timestamp is done"
done
stlcount=0
for timestamp in ${timelist[@]}
do
    flag05="FF"
    flag06="FF"
    flag07="FF"
    flag08="FF"
    flag09="FF"
    flag10="FF"
    flag11="FF"
    flag12="FF"
    files=""
    for video in /media/data/timelapse/timelapsevideo/*
    do
        if [[ "$video" == *"005-$videodate-$currentHour$timestamp"* ]];then
	    if [[ "$flag05" == *"F"* ]];then
		files+="-i $video "
		flag05="T"
	    fi
        elif [[ "$video" == *"006-$videodate-$currentHour$timestamp"* ]];then
	    if [[ "$flag06" == *"F"* ]];then
		files+="-i $video "
		flag06="T"
	    fi
        elif [[ "$video" == *"007-$videodate-$currentHour$timestamp"* ]];then
	    if [[ "$flag07" == *"F"* ]];then
		files+="-i $video "
		flag07="T"
	    fi
        elif [[ "$video" == *"008-$videodate-$currentHour$timestamp"* ]];then
	    if [[ "$flag08" == *"F"* ]];then
		files+="-i $video "
		flag08="T"
	    fi
        elif [[ "$video" == *"009-$videodate-$currentHour$timestamp"* ]];then
	    if [[ "$flag09" == *"F"* ]];then
		files+="-i $video "
		flag09="T"
	    fi
        elif [[ "$video" == *"010-$videodate-$currentHour$timestamp"* ]];then
	    if [[ "$flag10" == *"F"* ]];then
		files+="-i $video "
		flag10="T"
	    fi
        elif [[ "$video" == *"011-$videodate-$currentHour$timestamp"* ]];then
	    if [[ "$flag11" == *"F"* ]];then
		files+="-i $video "
		flag11="T"
	    fi
        elif [[ "$video" == *"012-$videodate-$currentHour$timestamp"* ]];then
	    if [[ "$flag12" == *"F"* ]];then
		files+="-i $video "
		flag12="T"
	    fi
        fi
    done

    ffmpeg $files \
    -filter_complex \
    " \
    [0:v]scale=540:960[v0];\
    [1:v]scale=540:960[v1];\
    [2:v]scale=540:960[v2];\
    [3:v]scale=540:960[v3];\
    [4:v]scale=540:960[v4];\
    [5:v]scale=540:960[v5];\
    [6:v]scale=540:960[v6];\
    [7:v]scale=1620:960[v7];\
    [v0][v1][v2][v3][v4]hstack=inputs=5[top];\
    [v5][v6][v7]hstack=inputs=3[bottom];\
    [top][bottom]vstack=inputs=2[v] \
    " \
    -map "[v]" /media/data/timelapse/$videodate/$currentHour/stacktimelapse$videodate$currentHour$timestamp.mp4
    stlcount=$(($stlcount + 1))

done
echo "~~~~~~~~~~~~~Stacked $stlcount Timelapse Videos This Time~~~~~~~~~~~~~~~~"
stlcount=0
duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=`printf "%.2f seconds" $duration`
echo "Script Execution Time: $execution_time"
rm -r /media/data/timelapse/timelapsevideo
mkdir /media/data/timelapse/timelapsevideo
# curl --upload-file ./$line https://transfer.sh/$line >>uploadlist.txt
