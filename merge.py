import sys
import os
import pathlib

import pandas as pd

root = "/Users/chen_yenru/Downloads/air_qu"
path = os.path.join(root, "空氣品質")

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

for file in os.listdir(os.chdir("data")):
    if file.endswith("csv"):
        master_df = master_df.append(pd.read_csv(file))

master_df.to_csv("combined.csv", index=False)
