#!/bin/bash

# Purpose: download MSWEP climate data (global daily precip data)
# (http://www.gloh2o.org/mswep/#faq)
# they make this data available by sharing a google drive folder
# the the data is large (~15 Gb/decade of data) and needs to be downloaded using rclone
# I'm dowloading this data to an external hard drive (not to the
# droughtnet box, because of the size of the data)

# Author: Martin Holdrege

# Script started: 12/20/2022

rclone ls --drive-shared-with-me gdrive:MSWEP_V280/Past/Daily --include "{{200[8-9]00\d.nc}}"

# where putting the files
dest=D:/IDE_climate_rasters/MSWEP_V280/Daily

# google drive folder (source)
source=gdrive:MSWEP_V280/Past/Daily

# test download of just two files
# rclone  sync --drive-shared-with-me "$source" "$dest" --include "{{200[8-9]365.nc}}"

# download all files for 2008 and 2009
rclone  sync --drive-shared-with-me "$source" "$dest" --include "{{200[8-9]\d\d\d.nc}}"

# download all files from 2010-2019
rclone  sync --drive-shared-with-me "$source" "$dest" --include "{{201[0-9]\d\d\d.nc}}"

# download additinal new files (>= 2020)
rclone  sync --drive-shared-with-me "$source" "$dest" --include "{{202[0-9]\d\d\d.nc}}"

# download the most recent files (they are in a different folder)
sourceNRT=gdrive:MSWEP_V280/NRT/Daily
rclone  sync --drive-shared-with-me "$sourceNRT" "$dest" --include "{{202[0-9]\d\d\d.nc}}"