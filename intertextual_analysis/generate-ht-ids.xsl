<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">

    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:apply-templates select="//relatedItem[@type = 'ht']/@target"/>
    </xsl:template>

    <xsl:template match="relatedItem/@target">
        <xsl:value-of select="concat(substring-after(., '2027/'), '&#x000a;')"/>
    </xsl:template>
</xsl:stylesheet>
