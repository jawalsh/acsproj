<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mets="http://www.loc.gov/METS/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xlink="http://www.w3.org/1999/xlink" version="2.0">

    <xsl:include href="tei2mets-conf.xsl"/>

    <xsl:output indent="yes"/>

    <xsl:param name="tei">
        <xsl:copy-of select="/TEI"/>
    </xsl:param>

    <xsl:variable name="teiID" select="/TEI/@xml:id"/>


    <xsl:template match="TEI">
        <mets:mets
            xsi:schemaLocation="http://www.loc.gov/METS/ http://www.loc.gov/standards/mets/mets.xsd">
            <xsl:attribute name="ID">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:call-template name="metsHdr"/>
            <xsl:call-template name="dmdSec"/>
            <xsl:call-template name="fileSec"/>
            <xsl:call-template name="structMap-physical"/>
            <xsl:call-template name="structMap-logical"/>
        </mets:mets>
    </xsl:template>

    <xsl:template name="metsHdr">
        <mets:metsHdr>
            <xsl:attribute name="CREATEDATE">
                <xsl:value-of select="substring-before(string(current-dateTime()), '.' )"/>
            </xsl:attribute>
            <mets:agent ROLE="CREATOR">
                <mets:name>
                    <xsl:value-of select="$creator"/>
                </mets:name>
            </mets:agent>
        </mets:metsHdr>
    </xsl:template>

    <xsl:template name="dmdSec">
        <mets:dmdSec ID="dmdTEIHDR">
            <mets:mdWrap MIMETYPE="text/xml" MDTYPE="TEIHDR" LABEL="TEI Header metadata">
                <mets:xmlData>
                    <xsl:copy-of select="/TEI/teiHeader"/>
                </mets:xmlData>
            </mets:mdWrap>

        </mets:dmdSec>
    </xsl:template>

    <xsl:template name="fileSec">
        <mets:fileSec>
            <mets:fileGrp>
                <xsl:for-each select="$imgform/tei:list/tei:item">
                    <xsl:apply-templates select="." mode="fileSec"/>
                </xsl:for-each>
            </mets:fileGrp>
        </mets:fileSec>
    </xsl:template>

    <xsl:template match="tei:item" mode="fileSec">
        <xsl:param name="n">
            <xsl:value-of select="@n"/>
        </xsl:param>
        <xsl:param name="ext">
            <xsl:value-of select="normalize-space(.//tei:item[@n='extension'])"/>
        </xsl:param>
        <xsl:param name="mime">
            <xsl:value-of select="normalize-space(.//tei:item[@n='mimetype'])"/>
        </xsl:param>
        <xsl:param name="loctype">
            <xsl:value-of select="normalize-space(.//tei:item[@n='loctype'])"/>
        </xsl:param>
        <xsl:param name="urlprefix">
            <xsl:value-of select="normalize-space(.//tei:item[@n='urlprefix'])"/>
        </xsl:param>

        <mets:fileGrp>
            <xsl:attribute name="USE">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:for-each select="$tei//pb[not(parent::orig)]">
                <xsl:variable name="page-id">
                    <xsl:value-of select='@facs'/>
                    <!--
                    <xsl:choose>
                        <xsl:when test="parent::reg and not(@xml:id) and @sameAs">
                            <xsl:value-of select="substring-after(@sameAs,'#')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@xml:id"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    -->
                </xsl:variable>
                <mets:file>
                    <xsl:attribute name="ID">
                        <xsl:value-of select="concat($page-id,'-',$n)"/>
                    </xsl:attribute>
                    <xsl:attribute name="GROUPID">
                        <xsl:value-of select="$page-id"/>
                    </xsl:attribute>
                    <xsl:attribute name="MIMETYPE">
                        <xsl:value-of select="$mime"/>
                    </xsl:attribute>
                    <xsl:attribute name="SEQ">
                        <xsl:number count="//pb[not(parent::orig)]" level="any"/>
                    </xsl:attribute>
                    <xsl:attribute name="USE">
                        <xsl:value-of select="$n"/>
                    </xsl:attribute>
                    <mets:FLocat>
                        <xsl:attribute name="LOCTYPE">
                            <xsl:value-of select="$loctype"/>
                        </xsl:attribute>
                        <xsl:attribute name="xlink:href">
                            <xsl:value-of select="concat($urlprefix,$page-id,$ext)"/>
                        </xsl:attribute>
                    </mets:FLocat>
                </mets:file>
            </xsl:for-each>
        </mets:fileGrp>
    </xsl:template>

    <xsl:template name="structMap-physical">
        <mets:structMap TYPE="physical">
            <mets:div ORDER="1">
                <xsl:attribute name="LABEL">
                    <xsl:call-template name="labelCitation"/>
                </xsl:attribute>
                <xsl:for-each select="//pb[not(parent::orig)]">
                    <xsl:apply-templates select="." mode="structMap-physical">
                        <xsl:with-param name="n">
                            <xsl:value-of select="@n"/>
                        </xsl:with-param>
                        <xsl:with-param name="page-id">
                            <xsl:value-of select="@facs"/>
                            <!--
                            <xsl:choose>
                                <xsl:when test="parent::reg and not(@xml:id) and @sameAs">
                                    <xsl:value-of select="substring-after(@sameAs,'#')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="@xml:id"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            -->
                        </xsl:with-param>
                    </xsl:apply-templates>
                </xsl:for-each>
            </mets:div>
        </mets:structMap>
    </xsl:template>

    <xsl:template match="pb" mode="structMap-physical">
        <xsl:param name="n"/>
        <xsl:param name="page-id"/>
        <mets:div TYPE="page">
            <xsl:attribute name="ORDER">
                <xsl:number count="//pb[not(parent::orig)]" level="any"/>
            </xsl:attribute>
            <xsl:if test="$n != ''">
                <xsl:attribute name="ORDERLABEL">
                    <xsl:value-of select="$n"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:for-each select="$imgform/tei:list/tei:item">
                <xsl:apply-templates select="." mode="structMap-physical">
                    <xsl:with-param name="n" select="$n"/>
                    <xsl:with-param name="page-id" select="$page-id"/>
                </xsl:apply-templates>
            </xsl:for-each>
        </mets:div>
    </xsl:template>

    <xsl:template match="tei:item" mode="structMap-physical">
        <xsl:param name="page-id"/>
        <mets:fptr>
            <!-- build up -->
            <xsl:attribute name="FILEID">
                <xsl:value-of select="concat($page-id,'-',@n)"/>
            </xsl:attribute>
        </mets:fptr>
    </xsl:template>

    <xsl:template name="structMap-logical">
        <mets:structMap TYPE="logical">
            <mets:div ORDER="1">
                <!-- <xsl:attribute name="CONTENTIDS" select="@xml:id"/> -->
                <xsl:attribute name="LABEL">
                    <xsl:call-template name="labelCitation"/>
                </xsl:attribute>
                <xsl:apply-templates select="/TEI/text"/>
            </mets:div>
        </mets:structMap>
    </xsl:template>

    <xsl:template match="//text[index]|//div[index]|//cell[index]|//floatingText[index]">
        <xsl:param name="indexed-element-id" select="@xml:id"/>
        <mets:div>
            <xsl:choose>
                <xsl:when test="index[@indexName = 'nav']">
                    
                        <xsl:choose>
                            <xsl:when test="ancestor::div[index[not(@indexName = 'nav')]]">
                                <xsl:attribute name="CONTENTIDS">
                                <xsl:value-of
                                    select="concat(ancestor::div[index[not(@indexName = 'nav')]][1]/@xml:id,'#',@xml:id)"
                                />
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:when test="ancestor::text[index[not(@indexName = 'nav')]]">
                                <xsl:attribute name="CONTENTIDS">
                                <xsl:value-of
                                    select="concat(ancestor::text[index[not(@indexName = 'nav')]][1]/@xml:id,'#',@xml:id)"
                                />
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="CONTENTIDS">
                                    <xsl:value-of
                                        select="concat(/TEI/@xml:id,'#',@xml:id)"
                                    />
                                </xsl:attribute>
                                <!--
                                <xsl:message select="concat('WARNING: No appropriate ancestor found for ',@xml:id,'!')"/>
                                -->
                            </xsl:otherwise>
                        </xsl:choose>
                </xsl:when>
                <xsl:when test="index[@indexName = 'meta']">
                    <!-- do nothing. -->
                    <!-- <xsl:value-of select="concat($teiID,'#',@xml:id)"/>-->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="CONTENTIDS">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:attribute name="ORDER">
                <xsl:value-of
                    select="count(preceding-sibling::*[not(name(.) = 'pb') or not(name(.) = 'head')]) + 1"
                />
            </xsl:attribute>
            <xsl:attribute name="TYPE">
                <xsl:choose>
                    <xsl:when test="name(.) = 'front'">
                        <xsl:value-of select="'frontmatter'"/>
                    </xsl:when>
                    <xsl:when test="name(.) = 'back'">
                        <xsl:value-of select="'backmatter'"/>
                    </xsl:when>
                    <xsl:when test="name(.) = 'body'">
                        <xsl:value-of select="'body'"/>
                    </xsl:when>
                    <xsl:when test="name(.) = 'titlePage'">
                        <xsl:value-of select="'title'"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@type"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="LABEL">
                <xsl:choose>
                    <xsl:when test="@n">
                        <xsl:value-of select="@n"/>
                    </xsl:when>
                    <xsl:when test="head">
                        <xsl:apply-templates select="head[1]" mode="LABEL"/>
                    </xsl:when>
                    <xsl:when test="front//titlePage/docTitle/titlePart">
                        <xsl:choose>
                            <xsl:when test="front//titlePage/docTitle/titlePart[@type = 'main']">
                                <xsl:value-of
                                    select="string(front//titlePage/docTitle/titlePart[@type = 'main'])"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="string(front//titlePage/docTitle)"/>
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
                        <xsl:message>Missing METS @LABEL in logical StructMap</xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:choose>
               <!-- special test for subdivisions that start on the same page as the super division. In such cases, the first page of the subdivision is not inside the sub-division, but precedes the subdivision. See "Four Songs of Fours Seaons" and "Translations from the French of Villon" in Poems, Vol. 3. --> 
               <xsl:when test=".//head[1][not(preceding::pb[ancestor::*[@xml:id = $indexed-element-id]])]">
                   <xsl:message select="concat('Message: test fired on element with id: ',$indexed-element-id)"/>
                   <xsl:apply-templates select="preceding::pb[position()=1]"/>
                  <!-- <xsl:if test=".//pb">-->
                       
                       <xsl:apply-templates/>
                  <!-- </xsl:if> -->
               </xsl:when>
               <xsl:when test=".//pb">
                
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="preceding::pb[position()=1]"/>
                </xsl:otherwise>
            </xsl:choose>
            <!-- added for nested div[index[@indexName = 'nav']], might break other files. -->
            <xsl:if test="//pb[@xml:id = 'dummy']">
                <xsl:apply-templates/>
            </xsl:if>
        </mets:div>
    </xsl:template>

    <xsl:template match="pb[not(parent::orig)]">
        <xsl:param name="n">
            <xsl:value-of select="@n"/>
        </xsl:param>
        <xsl:param name="page-id">
            <xsl:value-of select="@facs"/>
            <!--
            <xsl:choose>
                <xsl:when test="parent::reg and not(@xml:id) and @sameAs">
                    <xsl:value-of select="substring-after(@sameAs,'#')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@xml:id"/>
                </xsl:otherwise>
            </xsl:choose>
            -->
        </xsl:param>
        <xsl:param name="chunkId"/>
        <mets:div TYPE="page">
            <xsl:attribute name="ORDER">

                <xsl:value-of select="count(preceding::pb[ancestor::*[@xml:id = $chunkId]]) + 1"/>

            </xsl:attribute>
            <xsl:if test="$n != ''">
                <xsl:attribute name="ORDERLABEL">
                    <xsl:value-of select="$n"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:for-each select="$imgform/tei:list/tei:item">
                <xsl:apply-templates select="." mode="structMap-physical">
                    <xsl:with-param name="n" select="$n"/>
                    <xsl:with-param name="page-id" select="$page-id"/>
                </xsl:apply-templates>
            </xsl:for-each>
        </mets:div>
    </xsl:template>

    <xsl:template name="labelCitation">
        <xsl:value-of select="normalize-space(/TEI/teiHeader/fileDesc/titleStmt/author)"/>
        <xsl:if
            test="substring(normalize-space(/TEI/teiHeader/fileDesc/titleStmt/author),string-length(normalize-space(/TEI/teiHeader/fileDesc/titleStmt/author))) != '.'">
            <xsl:text>. </xsl:text>
        </xsl:if>
        <xsl:value-of select="normalize-space(/TEI/teiHeader/fileDesc/titleStmt/title)"/>
        <xsl:if
            test="substring(normalize-space(/TEI/teiHeader/fileDesc/titleStmt/title),string-length(normalize-space(/TEI/teiHeader/fileDesc/titleStmt/title))) != '.'">
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="text()"/>

    <xsl:template match="head//text()" mode="LABEL">
        <xsl:value-of select="."/>
    </xsl:template>




    <!-- 
        <mets:file ID="VAA1194-01-archive" GROUPID="VAA1194-01" MIMETYPE="image/tif" SEQ="1"
        CREATED="2004-07-22T14:00:00" USE="archive">
        <mets:FLocat LOCTYPE="PURL" xlink:href="http://purl.dlib.indiana.edu/iudl/"/>
        </mets:file>
    -->


    <xsl:template match="head//choice/orig|head//ref" mode="LABEL"/>


</xsl:stylesheet>
