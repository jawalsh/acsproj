#!/bin/bash

#Script that retrieves a specified set of images from the Swinburne Fedora Repository.   

i=10	#change this number to the first number specified in next line
while (($i >= 10 && $i<=13))   #this line is currently retrieving images 010, 011, 012, 013. Change these numbers to specify the set wanted.
do
        wget -r -np -e robots=off http://purl.dlib.indiana.edu/iudl/swinburne/large/acs0000001-01-`printf "%03d" $i` -P /Users/gracethomas/Downloads/files
        i=$((i+1))
done

#the 'printf' section of the wget command specifies that there must be three digits at the end of each URL. It will add leading zeros if the specified numbers of the while loop arguments are one or two digits. 
#change the numbers following 'acs' in the URL to specify which collection you would like to retrieve
#change the file path to save in specific file on local computer
