<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
    <xsl:output indent="yes" method="xml"/>
    <xsl:param name="output_file">
        <xsl:value-of select="concat(substring(/TEI/@xml:id,1,10),'-md.xml')"/>
    </xsl:param>
    <xsl:template match="/">
        <xsl:result-document method="xml" encoding="utf-8" indent="yes" href="{$output_file}">
        <xsl:processing-instruction name="oxygen">
            RNGSchema="/Users/jawalsh/development/tei/odd/RomaResults/swinburne.rnc" type="compact"
        </xsl:processing-instruction>
        <TEI>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat(substring(/TEI/@xml:id,1,10),'-md')"/>
            </xsl:attribute>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>
                            <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/>
                        </title>
                        <author>
                            <persName key="acs">Algernon Charles Swinburne</persName>
                        </author>
                        <editor role="editor">
                            <persName key="jawalsh">John A. Walsh</persName>
                        </editor>
                    </titleStmt>
                    <xsl:element name="include" namespace="http://www.w3.org/2001/XInclude">
                        <xsl:attribute name="href">
                            <xsl:value-of select="'includes/publicationStmt.xml'"/>
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="include" namespace="http://www.w3.org/2001/XInclude">
                        <xsl:attribute name="href">
                            <xsl:value-of select="'includes/seriesStmt.xml'"/>
                        </xsl:attribute>
                    </xsl:element>
                    <sourceDesc>
                        <p>This TEI/XML document is the original source.</p>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <xsl:element name="include" namespace="http://www.w3.org/2001/XInclude">
                        <xsl:attribute name="href">
                            <xsl:value-of select="'includes/tagsDecl.xml'"/>
                        </xsl:attribute>
                    </xsl:element>
                </encodingDesc>
                <xsl:copy-of select="/TEI/teiHeader/profileDesc"/>
                <revisionDesc>
                    <change n="svninfo">
                        $Id$
                        $Rev$
                        $Date$
                        $Author$
                    </change>
                </revisionDesc>
            </teiHeader>
            <text>
                <body>
                    <div xml:id="form">
                        <head>Form</head>
                        <list>
                            <item n="genre-main">poetry</item>
                            <xsl:if test="contains(TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title[@level = 'm'],'Roundel')">
                                <item n="genre-sub">roundel</item>
                            </xsl:if>
                        </list>
                    </div>
                    <!--
                    <div xml:id="commentary">
                        <head>Commentary</head>
                        <div xml:id="intro">
                            <head>Introduction</head>
                        </div>
                        <div xml:id="texthistcomp">
                            <head>Textual History: Composition</head>
                        </div>
                        <div xml:id="texthistrev">
                            <head>Textual History: Revision</head>
                        </div>
                        <div xml:id="prodhist">
                            <head>Production History</head>
                        </div>
                        <div xml:id="recepthist">
                            <head>Reception</head>
                        </div>
                        <div xml:id="printhist">
                            <head>Printing History</head>
                        </div>
                        <div xml:id="historical">
                            <head>Historical</head>
                        </div>
                        <div xml:id="literary">
                            <head>Literary</head>
                        </div>
                        <div xml:id="autobio">
                            <head>Autobiographical</head>
                        </div>
                        <div xml:id="biblio">
                            <head>Bibliographic</head>
                        </div>
                        <div xml:id="notes">
                            <head>Notes</head>
                        </div>
                    </div>
                    -->
                    <div xml:id="texts">
                        <head>texts</head>
                        <listBibl>
                            <biblStruct>
                                <xsl:attribute name="xml:id">
                                    <xsl:value-of select="concat(/TEI/@xml:id,'-bibl')"/>
                                </xsl:attribute>
                                <xsl:attribute name="n">
                                    <xsl:value-of select="'readingtext'"/>
                                </xsl:attribute>
                                <analytic>
                                    <title>
                                        <xsl:copy-of
                                            select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title[@level = 'a']/node()"
                                        />
                                    </title>
                                    <xsl:copy-of
                                        select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/author"
                                    />
                                </analytic>
                                <xsl:copy-of
                                    select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr[1]"
                                />
                            </biblStruct>
                            <biblStruct>
                                <analytic>
                                    <title>
                                        <xsl:copy-of
                                            select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title[@level = 'a']/node()"
                                        />
                                    </title>
                                    <xsl:copy-of
                                        select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/author"
                                    />
                                </analytic>
                                <monogr>
                                    <title>
                                        <xsl:copy-of
                                            select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/analytic/title[@level = 'm']/node()"
                                        />
                                    </title>
                                    <imprint>
                                        <xsl:copy-of
                                        select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr[@n = 'originallyPublishedIn']/imprint/pubPlace"/>
                                        <xsl:copy-of
                                        select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr[@n = 'originallyPublishedIn']/imprint/publisher"/>
                                        <date>
                                            <xsl:attribute name="n"><xsl:value-of select="'display'"/></xsl:attribute>
                                                <xsl:attribute name="when"><xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr[@n = 'originallyPublishedIn']/imprint/date/@when"/></xsl:attribute>
                                        </date>
                                    </imprint>
                                </monogr>
                            </biblStruct>
                        </listBibl>
                    </div>
                </body>
            </text>
        </TEI>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
