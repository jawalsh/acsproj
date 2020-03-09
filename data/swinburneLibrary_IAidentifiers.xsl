<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:template match="/">
                <xsl:apply-templates select="//relatedItem[@type = 'ia']"/>
    </xsl:template>
    
    <xsl:template match="teiHeader"/>
    
    <xsl:template match="relatedItem">

                    <xsl:value-of select="substring-before(substring-after(@target, 'https://archive.org/details/'),'/page')"/> <!-- Still need to figure out how to dismiss the '/page' to end. -->
                    <xsl:value-of select="'&#x000A;'"/>
    </xsl:template>
    
</xsl:stylesheet>