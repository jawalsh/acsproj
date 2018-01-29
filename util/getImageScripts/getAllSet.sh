#!/bin/bash

#Script that grabs all images of a collection from the Swinburne Fedora Repository.

i=0  
while (($i<=343))   #Change this number to reflect the highest numbered image in the collection
do
        wget -r -np -e robots=off http://purl.dlib.indiana.edu/iudl/swinburne/large/acs0000001-01-`printf "%03d" $i` -P /Users/gracethomas/Downloads/files
        i=$((i+1))
done

#the 'printf' section of the wget command specifies that there must be three digits at the end of each URL. It will add leading zeros if the specified numb$
#change the numbers following 'acs' in the URL to specify which collection you would like to retrieve
#change the file path to save in specific file on local computer

