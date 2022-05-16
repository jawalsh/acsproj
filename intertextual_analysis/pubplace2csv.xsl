<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    
    >
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <xsl:for-each select="/TEI/text/body//pubPlace">
            <xsl:value-of select="concat(normalize-space(.),',')"/>
            <xsl:value-of select="substring-after(@ref,'#')"/>
            <xsl:value-of select="'&#x000a;'"/>
        </xsl:for-each>
    </xsl:template>
    
   
</xsl:stylesheet>