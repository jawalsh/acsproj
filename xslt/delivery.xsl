<?xml version="1.0" encoding="UTF-8" ?>
<!-- =================================================== -->
<!-- This stylesheet performs a deep copy on source      -->
<!-- xml files to include external entities.             -->
<!-- Author: tlcamero@indiana.edu                        -->
<!-- =================================================== -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml"
	omit-xml-declaration="no"
	encoding="utf-8"/>

<xsl:template match="/">
   <xsl:copy-of select="node()"/>
</xsl:template>
   
</xsl:stylesheet>
