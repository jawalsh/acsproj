!/bin/sh
#run "IA_Files [user$] bash ../getTextFiles.bashrc" in Terminal.
for i in * #for all items in the downloaded IA_Files folder, do the following.
do 
    cd $i #calls the directory 
    mv ./*.txt ~/Desktop/IA_TextFiles #use custom path to mv text files to new folder.
    cd .. #get out of the directory to set up for the next item.
done