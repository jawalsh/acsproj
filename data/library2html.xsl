<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Swinburne’s Library</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="teiHeader"/>
    
    <xsl:template match="div[@type = 'day']">
        <div>
            <h1>Day <xsl:value-of select="@n"/></h1>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="div[@type = 'size']">
        <div>
            <h2>Size <xsl:value-of select="@n"/></h2>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="listBibl[@type = 'lot']">
        <div>
            <h3>Lot <xsl:value-of select="@xml:id"/></h3>
            <ul>
            <xsl:apply-templates/>
            </ul>
        </div>
    </xsl:template>
    
    <xsl:template match="biblStruct|bibl">
        <li><b><xsl:value-of select="concat(@xml:id,': ')"/></b>
            <ul>
                <xsl:apply-templates/>
            </ul>
        </li>
    </xsl:template>
    
    <xsl:template match="biblStruct//*|bibl//*">
        <li><b><xsl:value-of select="concat(local-name(),': ')"/></b><xsl:apply-templates/></li>
    </xsl:template>
    
</xsl:stylesheet>