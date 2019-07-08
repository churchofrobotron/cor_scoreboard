#!/usr/bin/env python3
import datetime
import shutil
import time

ALTAR_ID = "AFRU"
initials = "JJP"
score = 398450

while True:
  basename = initials.strip() + "_" + str(score) + "_" + datetime.datetime.now().isoformat() + "_" + ALTAR_ID
  shutil.copyfile("test.gif", "data/" + basename + ".gif")
  print("Copied")
  time.sleep(1)