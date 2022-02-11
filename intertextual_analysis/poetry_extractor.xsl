<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <results>
            <listEpigraph>
            <xsl:apply-templates select="//tei:epigraph"/>
            </listEpigraph>
            <listCit>
            <xsl:apply-templates select="//tei:cit"/>
            </listCit>
            <listHonor>
                <xsl:apply-templates select="//tei:head[contains(., 'Memory')]"/>
                <xsl:apply-templates select="//tei:head[contains(., 'For')]"/>
            </listHonor>
            
        </results>
    </xsl:template>
    <xsl:template match="//tei:epigraph">
        <epigraph>
            <cit>
                <xsl:choose>
                    <xsl:when test="./tei:cit">
                        <quote>
                            <xsl:value-of select="./tei:cit/tei:quote"/>
                        </quote>
                        <bibl>
                            <xsl:apply-templates select="./tei:cit/tei:bibl"/>
                        </bibl>
                    </xsl:when>
                    <xsl:otherwise>
                        <p>
                            <xsl:apply-templates/>
                        </p>
                    </xsl:otherwise>
                </xsl:choose>
            </cit>
        </epigraph>
    </xsl:template>
    <xsl:template match="tei:body/tei:head">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:cit[not(parent::tei:epigraph)]">
        <cit>
            <source type="poem">
                <xsl:apply-templates select="./ancestor::tei:body/tei:head"/>
            </source>
            <quote>
                <xsl:apply-templates select="./tei:quote"/>
            </quote>
            <bibl>
                <xsl:apply-templates select="./tei:bibl"/>
            </bibl>
        </cit>
    </xsl:template>
    <xsl:template match="//tei:head[contains(., 'Memory')]">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
    <xsl:template match="//tei:head[contains(., 'For ')]">
        <head>
            <xsl:apply-templates/>
        </head>
    </xsl:template>
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
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:bibl">
        <xsl:choose>
            <xsl:when test="./tei:author">
                <author>
                    <xsl:value-of select="./tei:author"/>
                </author>
            </xsl:when>
            <xsl:when test="./tei:title">
                <title>
                    <xsl:value-of select="./tei:title"/>
                </title>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:orig"/>
</xsl:stylesheet>
