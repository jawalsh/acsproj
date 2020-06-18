# csplit command to separate ProQuest download.
# File name default; asterisk was not working for flexible length.
# I made a new folder to put the files in, i.e. ~/Desktop/EEBOFiles was where I was calling the command from.

csplit -k ~/Desktop/ProQuestDocuments-2020-06-15.txt /____________________________________________________________/ {75}