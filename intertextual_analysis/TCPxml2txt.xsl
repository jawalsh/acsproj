<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="tei:TEI">
        <!-- replace the first part of concat with the desired folder path where you want to save things -->
        <xsl:result-document href="{concat('file:/C:/Users/Alex/Desktop/TCP/', //tei:idno[@type='DLPS'], '.txt')}" method="text">
        <xsl:apply-templates select="//tei:front"/>
        <xsl:apply-templates select="//tei:body"/>
        <xsl:apply-templates select="//tei:back"/>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="tei:front">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:body">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:back">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="//tei:teiHeader"/>
</xsl:stylesheet>