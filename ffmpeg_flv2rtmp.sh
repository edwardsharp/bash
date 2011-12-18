#!/bin/bash

ffmpeg -i sweet_trick.flv -re -acodec copy -vcodec copy -f flv rtmp://micronemez.com/live/manray
