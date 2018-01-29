#!/usr/bin/perl
if ($ARGV[0] ne 'html' and $ARGV[0] ne 'xml' and $ARGV[0] ne 'txt') {
	print STDERR ("usage: generatePurls <html|xml|txt>\n");
} else {
  opendir(DIR, "./data") or die "can't opendir . : $1";
  print ("<recs>");
  while (defined($file = readdir(DIR))) {
    if ($file =~ m/(.+?)\.xml/) {
	  if ($ARGV[0] eq 'xml') {
        print("<!-- $1 xml-->\n");
	    print("<rec>\n");
     	print("<purl>/swinburnearchive/xml/$1/</purl>\n");
        print("<url>http://www.letrs.indiana.edu/swinburne/xml/$1\.xml</url>\n");
     	print("</rec>\n\n");
      } elsif ($ARGV[0] eq 'html') {
        print("<!-- $1 html-->\n");
        print("<rec>\n");
        print("<purl>/swinburnearchive/html/$1/</purl>\n");
        print ("<url>http://swinburnearchive.indiana.edu/swinburne/view?docId=$1&amp;query=&amp;brand=swinburne</url>\n");
        print("<type>Batch_Modified</type>\n");
        print("<note>URL modified</note>\n");
        print("</rec>\n\n");
      } elsif ($ARGV[0] eq 'txt') {
    	print("<!-- $1 txt -->\n");
    	print("<rec>\n");
    	print("<purl>/swinburnearchive/txt/$1/</purl>\n");
    	print("<url>http://www.letrs.indiana.edu/swinburne/txt/$1\.txt</url>\n");
	    print("</rec>\n\n");
      }
    }
  }
  print ("</recs>");
  closedir(DIR);
}
