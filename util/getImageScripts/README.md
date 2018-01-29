Attached are two bash scripts to retrieve images from the Swinburne Fedora repository! If you don't already have wget, that is the tool used to scrape the images. I just used Homebrew to download it. If you also have that installed just run 

`$ brew install wget`

and you are good to go!

One script gets all images from a collection (getAllSet.sh) and the other gets just a specific set of images between numbers you specify (getSpecSet.sh).

All you have to do is change the target repository you want the images to go to once they are downloaded and the numbers for specific sets you want to retrieve each time! There are comments in each script explaining what to change.

Then just run it like a regular bash script on the command line. For example:

`$ bash getAllSet.sh`