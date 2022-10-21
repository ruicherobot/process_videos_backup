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

hourlist="00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23"
mkdir /media/data/timelapse/$videodate
for hourstamp in ${hourlist[@]}
do
    mkdir /media/data/timelapse/$videodate/$hourstamp
done
echo "Folders Are Created For Today $videodate !"
