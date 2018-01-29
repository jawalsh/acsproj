<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:variable name="teiID" select="/TEI/@xml:id"/>

    <xsl:template match="/">
        <list>
            <!-- <xsl:attribute name="xml:id" select="$teiID"/> -->
            <xsl:attribute name="n" select="/TEI/teiHeader/fileDesc/titleStmt/title"/>
            <xsl:apply-templates/>
        </list>
    </xsl:template>



    <xsl:template match="text[index]|div[index]">
        <item>
            <xsl:choose>
                <xsl:when test="index[@indexName = 'nav']">
                    <xsl:attribute name="xml:id">
                        <xsl:choose>
                            <xsl:when test="ancestor::div[index[not(@indexName = 'nav')]]">
                                <xsl:value-of
                                    select="concat(ancestor::div[index[not(@indexName = 'nav')]][1]/@xml:id,'#',@xml:id)"
                                />
                            </xsl:when>
                            <xsl:when test="ancestor::text[index[not(@indexName = 'nav')]]">
                                <xsl:value-of
                                    select="concat(ancestor::text[index[not(@indexName = 'nav')]][1]/@xml:id,'#',@xml:id)"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:message select="'WARNING: No appropriate ancestor found!'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="index[@indexName = 'meta']">
                    <!-- do nothing. -->
                    <!-- <xsl:value-of select="concat($teiID,'#',@xml:id)"/>-->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:attribute name="n">
                <xsl:call-template name="get_label"/>
            </xsl:attribute>

            <xsl:if test=".//text[index]|.//div[index]">
                <list>
                    <xsl:apply-templates/>
                </list>
            </xsl:if>
        </item>
    </xsl:template>





    <xsl:template match="text()"/>

    <xsl:template name="get_label">
        <xsl:param name="label">
            <xsl:choose>
                <xsl:when test="@n">
                    <xsl:value-of select="@n"/>
                </xsl:when>
                <xsl:when test="head">
                    <xsl:apply-templates select="head[1]" mode="LABEL"/>
                </xsl:when>
                <xsl:when test="front//titlePage/docTitle">
                    <xsl:choose>
                        <xsl:when test="front//titlePage/docTitle/titlePart[@type = 'main']">
                            <xsl:apply-templates
                                select="front//titlePage/docTitle/titlePart[@type = 'main']"
                                mode="LABEL"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="front//titlePage/docTitle" mode="LABEL"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="front//head">
                    <xsl:apply-templates select="front//head[1]" mode="LABEL"/>
                </xsl:when>
                <xsl:when test="body/head">
                    <xsl:apply-templates select="body/head[1]" mode="LABEL"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'[dummy]'"/>
                    <xsl:message>Missing title for work.</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:value-of select="normalize-space($label)"/>
    </xsl:template>

</xsl:stylesheet>
