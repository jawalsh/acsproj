<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="3.0">
    <xsl:template match="/">
        <xsl:apply-templates select="/TEI/text//author"/>
            
        
    </xsl:template>
    
    <xsl:template match="author">
        <xsl:param name="corresp" select="substring-after(@corresp,'#')"/>
        <xsl:choose>
            <xsl:when test="@corresp">
                <xsl:value-of select="normalize-space(/TEI/text/front/div/listPerson/person[@xml:id = $corresp]/persName)"/>
                
                <!-- get controlled author name. -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="'&#x000a;'"/>
    </xsl:template>
</xsl:stylesheet>