<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:template match="/">
        <xsl:call-template name="first_published"/>    
    </xsl:template>
    
    <xsl:template name="first_published">
        <xsl:for-each select="//biblStruct">
            <xsl:sort order="descending" select="monogr/imprint/date/@when"/>
            <xsl:if test="position() = last()">
                <xsl:value-of select="monogr/imprint/date/@when"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    

        
        
    
    
</xsl:stylesheet>