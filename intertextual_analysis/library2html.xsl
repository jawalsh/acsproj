<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <!-- test sb728.1 -->
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Swinburne’s Library</title>
                <link rel="stylesheet" href="library.css"/>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="teiHeader"/>

    <xsl:template match="div[@type = 'day']">
        <div class="day">
            <h1>Day <xsl:value-of select="@n"/></h1>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="div[@type = 'size']">
        <div class="size">
            <h2>Size <xsl:value-of select="@n"/></h2>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="listBibl[@type = 'lot']">
        
                <xsl:apply-templates/>
    </xsl:template>
    

    <xsl:template match="biblStruct | bibl">
        <div class="bibitem">
            <ul>
                <li><b>id: </b><xsl:value-of select="concat(@xml:id, ': ')"/></li>
        
                <xsl:apply-templates/>
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="biblStruct//note|biblStruct/monogr/title|biblStruct/monogr/author|biblStruct/monogr/imprint/date|biblStruct/monogr/imprint/publisher|biblStruct/monogr/imprint/pubPlace|bibl/title|bibl/author|bibl/date">
        <li>
            <b>
                <xsl:value-of select="concat(local-name(), ': ')"/>
            </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="monogr | imprint | note/date | resp | respStmt/name" priority="10">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="note[@type = 'etc']" priority="10">
        <li>
            <b>additional undocumented volumes: </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="note[@type = 'inscription']" priority="10">
        <li>
            <b>inscription: </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="note" priority="9">
        <li>
            <b>note<xsl:if test="@resp"> (<xsl:value-of select="substring-after(@resp,'#')"/>)</xsl:if>: </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    

    <xsl:template match="num" priority="10">
        <xsl:value-of select="@value"/>
    </xsl:template>

    <xsl:template match="imprint/date[@when]" priority="10">
        <li>
            <b>date: </b>
            <xsl:apply-templates/>
            <xsl:value-of select="@when"/>
        </li>
    </xsl:template>
    
    <xsl:template match="imprint/date[@from]" priority="10">
        <li>
            <b>date: </b>
            <xsl:apply-templates/>
            <xsl:value-of select="concat(@from,'-',@to)"/>
        </li>
    </xsl:template>

    <xsl:template match="pubPlace" priority="10">
        <li>
            <b>place of publication: </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="extent" priority="10">
        <li>
            <b>extent: </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="measure" priority="10">
        <xsl:value-of select="concat(@quantity, ' ')"/>
        <xsl:choose>
            <xsl:when test="@quantity = 1">
                <xsl:value-of select="substring(@unit, 1, string-length(@unit) - 1)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@unit"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="respStmt" priority="10">
        <li>
            <b>contributor: </b>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="relatedItem" priority="10">
        <li>
            <b>full-text <xsl:if test="@n">vol. <xsl:value-of select="concat(@n,' ')"/></xsl:if>(<xsl:value-of select="@type"/>): </b>
            <a href="{@target}"><xsl:value-of select="@target"/></a>
            
        </li>
    </xsl:template>
    
    <xsl:template match="ref">
        <a href="{@target}"><xsl:apply-templates/></a>
    </xsl:template>



</xsl:stylesheet>
