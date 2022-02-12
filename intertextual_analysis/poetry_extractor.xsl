<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <!-- root template -->
    <xsl:template match="/">
        <results>
            <listCit>
                <xsl:apply-templates select="//tei:cit"/>
            </listCit>
            <!-- poems in honor of someone/thing -->
            <listHonor>
                <xsl:apply-templates select="//tei:head[contains(., 'Memory')]"/>
                <xsl:apply-templates select="//tei:head[contains(., 'For ')]"/>
            </listHonor>
        </results>
    </xsl:template>

    <!-- other templates -->
    <xsl:template match="//tei:cit">
        <xsl:choose>
            <xsl:when test=".[parent::tei:epigraph]">
                <cit vol="{substring-after(./ancestor::tei:TEI/@xml:id, 'acs0000001-0')}" type="epigraph" corresp="swinburne_library.xml#{./ancestor::tei:text[@type='poem']/@xml:id}">
                    <xsl:apply-templates select="./tei:quote"/>                  
                    <xsl:apply-templates select="./tei:bibl"/>
                </cit>
            </xsl:when>
            <xsl:otherwise>
                <cit vol="{substring-after(./ancestor::tei:TEI/@xml:id, 'acs0000001-0')}" corresp="swinburne_library.xml#{./ancestor::tei:text[@type='poem']/@xml:id}">
                    <xsl:apply-templates select="./tei:quote"/>                  
                    <xsl:apply-templates select="./tei:bibl"/>
                </cit>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- For listHonor -->
    <xsl:template match="//tei:head[contains(., 'Memory')]">
        <head vol="{substring-after(./ancestor::tei:TEI/@xml:id, 'acs0000001-0')}" corresp="swinburne_library.xml#{./ancestor::tei:text[@type='poem']/@xml:id}">
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    <xsl:template match="//tei:head[contains(., 'For ')]">
        <head vol="{substring-after(./ancestor::tei:TEI/@xml:id, 'acs0000001-0')}" corresp="swinburne_library.xml#{./ancestor::tei:text[@type='poem']/@xml:id}">
            <xsl:apply-templates/>
        </head>
    </xsl:template>

    <!-- component templates -->
    <xsl:template match="//tei:head//tei:persName">
        <persName>
            <xsl:apply-templates/>
        </persName>
    </xsl:template>
    <xsl:template match="tei:date">
        <date>
            <xsl:apply-templates/>
        </date>
    </xsl:template>
    <xsl:template match="tei:quote">
        <quote>
            <xsl:apply-templates/>
        </quote>
    </xsl:template>
    <!-- bibl template -->
    <xsl:template match="tei:bibl">
        <bibl>
            <!--
            <xsl:choose>
                <xsl:when test="./tei:author">
                    <xsl:apply-templates select="./tei:author"/>
                </xsl:when>
                <xsl:when test="./tei:title">
                    <xsl:apply-templates select="./tei:title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>-->
            <xsl:apply-templates/>
        </bibl>
    </xsl:template>
    <!-- title and author templates -->
    <xsl:template match="tei:author">
        <author>
            <xsl:apply-templates/>
        </author>
    </xsl:template>
    <xsl:template match="tei:title">
        <title>
            <xsl:apply-templates/>
        </title>
    </xsl:template>
    <xsl:template match="tei:biblScope">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="tei:bibl/text()"/>
    <xsl:template match="tei:head">
        <head>
        <xsl:apply-templates/>
        </head>
    </xsl:template>
    <!-- empty templates -->
    <xsl:template match="//tei:choice//tei:orig"/>
    <xsl:template match="//tei:choice//tei:abbr"/>
</xsl:stylesheet>
