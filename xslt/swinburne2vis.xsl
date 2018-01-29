<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">

    <!-- xmlns="http://www.tei-c.org/ns/1.0"> -->

    <xsl:output encoding="UTF-8" method="xml" indent="no"/>
    <xsl:template match="/">
        <root>
        <xsl:call-template name="keywords"/>
        <text> 
           
            <xsl:apply-templates/>
        </text>
        </root>
    </xsl:template>


    <xsl:template match="TEI/text">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="teiHeader"/>


    <xsl:template match="item">
        <xsl:apply-templates/>
        <xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="head">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    
    <xsl:template match="l/label"/>

    <xsl:template match="lb">
        <xsl:text>
</xsl:text>
    </xsl:template>

    <xsl:template match="lg|l|epigraph|cit|quote|bibl|w">
        <xsl:param name="e-name">
            <xsl:value-of select="name(.)"/>
        </xsl:param>
        <xsl:element name="{$e-name}">
            <!-- <xsl:copy-of select="@*"/> -->
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="seg[@type='keyword']">
        <seg>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </seg>
    </xsl:template>
    
    <xsl:template match="*[contains(@rendition,'#suppress')]"/>


    <xsl:template match="note|back|@rendition"/>
    
    <xsl:template name="keywords">
        <xsl:copy-of select="//taxonomy[@xml:id='thematic_keywords']"/>
    </xsl:template>
    
    
   


</xsl:stylesheet>
