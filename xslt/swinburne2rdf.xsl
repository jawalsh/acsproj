<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:collex="http://www.collex.org/schema#"
    xmlns:swinburne="http://www.swinburnearchive.org/namespace/swinburne/"
    xmlns:role="http://www.loc.gov/loc.terms/relators/" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:xtm="http://www.topicmaps.org/xtm/" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
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
        <xsl:choose>
            <xsl:when test="//idno[@type = 'nines']">
                <xsl:for-each select="//idno[@type='nines']">
                    <xsl:variable name="id" select="normalize-space(.)"/>
                    <xsl:call-template name="rdfFile">
                        <xsl:with-param name="id" select="normalize-space(.)"/>
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="rdfFile">
                    <xsl:with-param name="id" select="/TEI/@xml:id"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    
    <xsl:template match="/TEI" name="rdfFile">
        <xsl:param name="id"/>
        <!--
        <xsl:param name="vol">
            <xsl:value-of select="substring($id,0,3)"/>
        </xsl:param>
        -->

        <xsl:result-document href="{concat($id,'.rdf')}">
            <rdf:RDF>
                <swinburne:sad rdf:about="{concat('http://www.swinburnearchive.org/id/',normalize-space($id),'/')}">
                    <xsl:comment> DC metadata </xsl:comment>
                    <xsl:if test="/TEI/teiHeader/fileDesc/titleStmt/author">
                        <xsl:variable name="xtmid">
                            <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/author/persName/@key"
                            />
                        </xsl:variable>
                        <role:AUT>
                            <xsl:value-of select="$xtm//xtm:topic[@id=$xtmid]/xtm:name/xtm:value"/>
                        </role:AUT>
                    </xsl:if>
                    <xsl:if test="/TEI/teiHeader/fileDesc/titleStmt/editor">
                        <xsl:variable name="xtmid">
                            <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/editor/persName/@key"
                            />
                        </xsl:variable>
                        <role:EDT>
                            <xsl:value-of select="$xtm//xtm:topic[@id=$xtmid]/xtm:name/xtm:value"/>
                        </role:EDT>
                    </xsl:if>
                    <!--
                <xsl:if test="teiHeader/fileDesc/titleStmt/editor">
                    <role:EDT>
                        <xsl:value-of select="teiHeader/fileDesc/titleStmt/editor/persName/@reg"/>
                    </role:EDT>
                </xsl:if>
                -->
                    <xsl:choose>
                        <xsl:when
                            test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr[not(@n)]/imprint/publisher">
                            <role:PBL>
                                <xsl:value-of
                                    select="normalize-space(/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr[not(@n)]/imprint/publisher)"
                                />
                            </role:PBL>
                        </xsl:when>
                        <xsl:when test="/TEI/teiHeader/fileDesc/publicationStmt/publisher">
                            <role:PBL>
                                <xsl:value-of
                                    select="/TEI/teiHeader/fileDesc/publicationStmt/publisher"/>
                            </role:PBL>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message>No role:EDT present in current document</xsl:message>
                        </xsl:otherwise>
                    </xsl:choose>

                    <!-- <role:PBL>Indiana University Digital Library Program</role:PBL> -->
                    <dc:title>
                        <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/>
                    </dc:title>


                    <xsl:choose>
                        <xsl:when test="//catRef">
                            <xsl:for-each select="//catRef">
                                <collex:genre>
                                    <xsl:value-of
                                        select="normalize-space(id(substring-after(@target,'#')))"/>
                                </collex:genre>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <collex:genre>
                                <xsl:value-of select="'NO_GENRE'"/>
                            </collex:genre>
                            <xsl:message select="concat('NO_GENRE: ', /TEI/@xml:id)"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <collex:genre>
                        <xsl:choose>
                            <!-- IDs over 500 are reserved for secondary sources. If primary source material goes past 499, we'll have to set up multiple ranges. Or better, add secondary primary designation to source. -->
                            <xsl:when test="number(substring(/TEI/@xml:id,8,3)) >= 500">
                                <xsl:text>Secondary</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>Primary</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </collex:genre>
                    <dc:date>
                        <xsl:choose>
                            <xsl:when
                                test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/relatedItem/biblStruct[@n='original_collection']/monogr/imprint/date/@when">
                                <xsl:apply-templates
                                    select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/relatedItem/biblStruct[@n='original_collection']/monogr/imprint/date/@when"
                                />
                            </xsl:when>
                            <xsl:when
                                test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date/@when">
                                <xsl:apply-templates
                                    select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/imprint/date/@when"
                                />
                            </xsl:when>
                            <xsl:when test="/TEI/teiHeader/fileDesc/publicationStmt/date/@value">
                                <xsl:apply-templates
                                    select="/TEI/teiHeader/fileDesc/publicationStmt/date/@value"/>
                            </xsl:when>
                        </xsl:choose>
                    </dc:date>
                    <xsl:text>
                    
                </xsl:text>
                    <xsl:comment> NINES metadata </xsl:comment>
                    <collex:archive>swinburne</collex:archive>
                    <collex:thumbnail
                        rdf:resource="http://www.purl.org/swinburnearchive/img/tsa9thmb00/"/>
                    <collex:source_xml>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of
                                select="concat('http://www.purl.org/swinburnearchive/source/xml/',/TEI/@xml:id,'/')"
                            />
                        </xsl:attribute>
                    </collex:source_xml>
                    <xsl:text>
                    
                </xsl:text>
                    <collex:text>
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of
                                select="concat('http://www.purl.org/swinburnearchive/txt/',/TEI/@xml:id,'.txt')"
                            />
                        </xsl:attribute>
                    </collex:text>
                    <xsl:comment> Link for end users </xsl:comment>
                    <rdfs:seeAlso>
                        <xsl:value-of
                            select="concat('http://www.purl.org/swinburnearchive/xml/',/TEI/@xml:id,'/')"
                        />
                        <!--
                        <xsl:attribute name="rdf:resource">
                            <xsl:value-of
                                select="concat('http://www.purl.org/swinburnearchive/html/',$id,'/')"
                            />
                        </xsl:attribute>
                        -->
                    </rdfs:seeAlso>
                    <collex:federation>NINES</collex:federation>
                </swinburne:sad>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
