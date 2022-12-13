import argparse
import os
import signal
import sys
import time
import shutil

def process_dir(days, base_path):
    dirs = os.listdir(base_path)
    video_num = 0
    sort_num_first = []
    for dir in dirs:
        dir_split = dir.split('-')
        if len(dir_split) == 3:
            video_num += 1
            sort_num_first.append(int(dir_split[0] + \
                                      dir_split[1] + \
                                      dir_split[2]))
    sort_num_first.sort()
    sorted_dir = []
    for sort_num in sort_num_first:
        for dir in dirs:
            dir_split = dir.split('-')
            if len(dir_split) == 3:
                if str(sort_num) == str(int(dir_split[0] + \
                                            dir_split[1] + \
                                            dir_split[2])):
                    sorted_dir.append(dir)
    if len(sorted_dir) > days:
        for i in range(len(sorted_dir) - days):
            shutil.rmtree(os.path.join(base_path, sorted_dir[i]))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--days', default=49, type=int,
                        help="media dirs containes how many days' data")
    parser.add_argument('-l', '--location', default="/media/data", type=str,
                        help="media dirs containes how many days' data")
    args = parser.parse_args()
    process_dir(args.days, args.location)
    # 0 1 * * * python /opt/tv/dev/process_data_days.sh --days 49 --l /media/data

