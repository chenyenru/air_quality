import sys
import os
import pathlib

import pandas as pd

root = "/Users/chen_yenru/Documents/GitHub/air_qu/"
path = os.path.join(root, "aqx")

# data_list = []
# for path, subdirs, files in os.walk(root):
#     for name in files:
#         print(os.path.join(path, name))

# filenames = [os.path.join(path, name)
#              for path, subdirs, files in os.walk(root) for name in files]
# print(filenames)
# del filenames[1]
# print(filenames)

# combined_csv = pd.concat([pd.read_csv(f) for f in filenames])

master_df = pd.DataFrame()

for file in os.listdir(os.chdir("aqx")):
    if file.endswith("csv"):
        master_df = master_df.append(pd.read_csv(file))

master_df.to_csv("combined2.csv", index=False)

"""" actual merging, type this in terminal
for FILE in *.csv
do
        exec 5<"$FILE" # Open file
        read LINE <&5 # Read first line
        [ -z "$FIRST" ] && echo "$LINE" # Print it only from first file
        FIRST="no"

        cat <&5 # Print the rest directly to standard output
        exec 5<&- # Close file
        # Redirect stdout for this section into file.out
done > file.csv
"""
