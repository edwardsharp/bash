#!/bin/bash

ls | grep " " | while read -r file_name ; do mv -v "$file_name" `echo $file_name | tr -d ' '` ; done
