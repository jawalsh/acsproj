<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      exclude-result-prefixes="xs"
      version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:template match="/">
        <xsl:for-each select="/TEI/text//persName">
            <xsl:value-of select="."/>
            <xsl:text>
            </xsl:text>
        </xsl:for-each>
    </xsl:template>
    

</xsl:stylesheet>
