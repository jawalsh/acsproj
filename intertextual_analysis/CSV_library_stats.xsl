<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="text"/>
    <xsl:template match="/">
Year, Entries
        <xsl:for-each-group select="//tei:body//tei:biblStruct[@corresp[contains(., 'owned')]]" group-by=".//tei:imprint/tei:date/@when|.//tei:imprint/tei:date/@from">
            <xsl:sort select="number(current-grouping-key())"/>
            <xsl:value-of select="current-grouping-key()"/>, <xsl:value-of select="count(current-group())"/>,
        </xsl:for-each-group>
        
    </xsl:template>
</xsl:stylesheet>