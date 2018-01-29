<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

<xsl:template name="tagUsage">
    <tagsDecl>
        <tagUsage>
            <xsl:attribute name="gi">
                <xsl:value-of select="name()"/>
            </xsl:attribute>
            <xsl:attribute name="occurs">
                <xsl:value-of select="count()"/>
            </xsl:attribute>
        </tagUsage>
    </tagsDecl>
</xsl:stylesheet>
