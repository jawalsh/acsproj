<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Internet Archive Identifiers</title>
                <style type="text/css" rel="stylesheet">
                    body{
                    font-family: 'helvetica-neue',helvetica,sans-serif;
                    line-height: 1.5;
                    margin-left: 5em;
                    }
                </style>
            </head>
            <body>
                <h1>Internet Archive Identifiers</h1>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="teiHeader"/>
    
    <xsl:template match="listBibl">
        <xsl:for-each select="biblStruct">
            <xsl:for-each select="relatedItem">
                <xsl:if test="@type='ia'">
                    <xsl:value-of select="substring-after(@target, 'https://archive.org/details/')"/> <!-- Still need to figure out how to dismiss the '/page' to end. -->
                    <br></br>
                </xsl:if>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>