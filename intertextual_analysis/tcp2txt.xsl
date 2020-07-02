<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" >
    
    <xsl:template match="/">
        <xsl:apply-templates select="/tei:TEI/tei:text"/>
    </xsl:template>
    
    <xsl:template match="tei:fw"/>
    
</xsl:stylesheet>