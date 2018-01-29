<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xtm="http://www.topicmaps.org/xtm/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xtm">
    <xsl:output method="xml" encoding="utf-8" indent="yes"/>
    
    <xsl:param name="dataRoot" as="xs:string">
        <xsl:value-of select="'/Users/jawalsh/development/swinburne/data/'"/>
    </xsl:param>
    
    <xsl:param name="xtmFile" as="xs:string">
        <xsl:value-of select="'swinburne.xtm'"/>
        
    </xsl:param>
    
    <xsl:variable name="xtm">
        <xsl:copy-of select="document(concat('file://',$dataRoot,$xtmFile))"/>
    </xsl:variable>
    
    <xsl:template match="/">
        <x>
            <dc>
 
                <xsl:apply-templates select="/TEI/teiHeader/fileDesc/titleStmt/title"/>
                <xsl:apply-templates select="/TEI/@xml:id"/>
                <xsl:apply-templates select="TEI/teiHeader/fileDesc/titleStmt/author/persName"/>
                <xsl:apply-templates select="TEI/teiHeader/fileDesc/titleStmt/editor/persName"/>
                <xsl:apply-templates select="/TEI/teiHeader/fileDesc/publicationStmt/publisher"/>
                <xsl:choose>
                    <xsl:when
                        test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr[@n='originallyPublishedIn']/imprint/date/@value">
                        <xsl:apply-templates
                            select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr[@n='originallyPublishedIn']/imprint/date/@value"
                        />
                    </xsl:when>
                    <xsl:when
                        test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date/@value">
                        <xsl:apply-templates
                            select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date/@value"
                        />
                    </xsl:when>

                    <xsl:when test="/TEI/teiHeader/fileDesc/publicationStmt/date/@value">
                        <xsl:apply-templates
                            select="/TEI/teiHeader/fileDesc/publicationStmt/date/@value"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <date>no date</date>
                    </xsl:otherwise>
                </xsl:choose>


                <xsl:apply-templates select="/TEI/teiHeader/fileDesc/publicationStmt/availability"/>
                <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct">
                    <xsl:apply-templates select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct"
                        mode="workInAnAnthology"/>
                </xsl:if>

                <xsl:apply-templates
                    select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title[@level='m']"/>
                <xsl:apply-templates
                    select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title"/>
                <!--
                <xsl:call-template name="dc.title"/>
                <xsl:call-template name="dc.creator"/>
                <xsl:call-template name="dc.contributor"/>
                <xsl:call-template name="dc.identifier"/>
                <xsl:call-template name="dc.publisher"/>
                <xsl:call-template name="dc.rights"/>
                <xsl:call-template name="dc.date"/>
                -->
                <xsl:call-template name="staticContent"/>
            </dc>
        </x>
    </xsl:template>
    <!-- dc.title -->
    <xsl:template name="dc.title" match="/TEI/teiHeader/fileDesc/titleStmt/title">
        <title>
            <xsl:value-of select="normalize-space(.)"/>
        </title>
    </xsl:template>
    <!-- dc.identifier -->
    <xsl:template name="dc.identifier" match="/TEI/@xml:id">
        <identifier>
            <xsl:value-of select="normalize-space(.)"/>
        </identifier>
    </xsl:template>
    <!-- dc.creator -->
    <xsl:template name="dc.creator" match="/TEI/teiHeader/fileDesc/titleStmt/author/persName">
        <xsl:param name="key">
            <xsl:value-of select="@key"/>
        </xsl:param>
        <creator>
            <xsl:value-of
                select="$xtm//xtm:topic[@id=$key]/xtm:name/xtm:value"/>
        </creator>
    </xsl:template>
    <!-- dc.contributor -->
    <xsl:template name="dc.contributor" match="/TEI/teiHeader/fileDesc/titleStmt/editor/persName">
        <xsl:param name="key">
            <xsl:value-of select="@key"/>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="/TEI/teiHeader/fileDesc/titleStmt/author/persName">
                <contributor>
                    <xsl:value-of
                        select="$xtm//xtm:topic[@id=$key]/xtm:name/xtm:value"
                    />
                </contributor>
            </xsl:when>
            <xsl:otherwise>
                <creator>
                    <xsl:value-of
                        select="$xtm//xtm:topic[@id=$key]/xtm:name/xtm:value"
                    />
                </creator>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- dc.description: not used -->
    <!-- dc.publisher -->
    <xsl:template name="dc.publisher" match="/TEI/teiHeader/fileDesc/publicationStmt/publisher">
        <publisher>
            <xsl:value-of select="normalize-space(.)"/>
        </publisher>
    </xsl:template>
    <!-- dc.date -->
    <xsl:template name="dc.date" match="/TEI/teiHeader/fileDesc/publicationStmt/date/@value">
        <date>
            <xsl:value-of select="normalize-space(.)"/>
        </date>
    </xsl:template>
    <xsl:template name="dc.date.originalPublication"
        match="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr[@n='originallyPublishedIn']/imprint/date/@value">
        <date type="originalPublication">
            <xsl:value-of select="normalize-space(.)"/>
        </date>

    </xsl:template>
    <!-- dc.rights -->
    <xsl:template name="dc.rights" match="/TEI/teiHeader/fileDesc/publicationStmt/availability">
        <rights>
            <xsl:value-of select="normalize-space(.)"/>
        </rights>
    </xsl:template>
    <!-- dc.relation -->
    <xsl:template name="dc.relation"
        match="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title[@level='m']">
        <xsl:if test="preceding-sibling::title[@level='a']">
            <relation type="Is Part Of">
                <xsl:value-of select="normalize-space(.)"/>
            </relation>
        </xsl:if>
    </xsl:template>

    <xsl:template name="staticContent">
        <coverage>Victorian Period, 1832-1901</coverage>
        <language>English</language>
        <format>text/xml</format>
        <type>text</type>
    </xsl:template>


    <xsl:template match="biblStruct" mode="workInAnAnthology">
        <source>
            <xsl:value-of select="normalize-space(./analytic/author)"/>
            <xsl:text>. </xsl:text>
            <xsl:choose>
                <xsl:when test="count(./analytic/title) = 1">
                    <xsl:value-of select="normalize-space(./analytic/title)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space(./analytic/title[@level='a'])"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="normalize-space(./monogr[not(@n)]/title)"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="normalize-space(./monogr[not(@n)]/extent)"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="normalize-space(./monogr[not(@n)]/imprint/pubPlace)"/>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="normalize-space(./monogr[not(@n)]/imprint/publisher)"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="normalize-space(./monogr[not(@n)]/imprint/date)"/>
            <xsl:text>. </xsl:text>
            <xsl:if
                test="./monogr[not(@n)]/imprint/biblScope[@type='volume'] and ./monogr/imprint/biblScope[@type='pages']">
                <xsl:value-of select="normalize-space(./monogr[not(@n)]/imprint/biblScope[@type='volume'])"/>
                <xsl:text>: </xsl:text>
                <xsl:value-of select="normalize-space(./monogr[not(@n)]/imprint/biblScope[@type='pages'])"/>
                <xsl:text>.</xsl:text>
            </xsl:if>
        </source>
    </xsl:template>
   

    <xsl:template match="*"/>
</xsl:stylesheet>
