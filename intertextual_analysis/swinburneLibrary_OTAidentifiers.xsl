<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:template match="/">
                <xsl:apply-templates select="//relatedItem[@type = 'ota']"/>
    </xsl:template>
    
    <xsl:template match="teiHeader"/>
    
    <xsl:template match="relatedItem">
        <xsl:value-of select="(substring-after(@target, 'http://hdl.handle.net/*/'))"/>
        <xsl:value-of select="'A\d*;'"/>
    </xsl:template>
    
</xsl:stylesheet>