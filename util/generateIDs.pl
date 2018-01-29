#!/usr/bin/perl
opendir(DIR, "./data") or die "can't opendir . : $1";
while (defined($file = readdir(DIR))) {
  if ($file =~ m/(.+?)\.xml/) {
    system("mkdir -p ./dataIDs");
    system("xsltproc /Users/jawalsh/development/utilities/xml/generateIDs.xsl ./data/$file > ./dataIDs/$file");
  }
}
closedir(DIR);


