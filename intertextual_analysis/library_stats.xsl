<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:template match="/">
        <html>
            <head><title>Swinburne Library Stats</title></head>
            <body>
                <h1>Swinburne Library Stats</h1>
                <ul>
                    <h2>Relation to Swinburne</h2>
                    <li>Owned: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'owned')]])"/></li>
                    <li>Annotated: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'annotated')]])"/></li>
                    <li>Corrected: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'corrected')]])"/></li>
                    <li>Signed: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'signed')]])"/></li>
                    <li>Presented by Swinburne: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'presented_by')]])"/></li>
                    <li>Received by Swinburne: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'received')]])"/></li>
                    <li>Referenced by Swinburne: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'referenced')]])"/></li>
                    <li>Presented to Swinburne: <xsl:value-of select="count(//tei:biblStruct[.//tei:note[@corresp[contains(.,'presentation')]] and .[@corresp[contains(., 'owned')]]])"/></li> 
                    <li><b>Total: <xsl:value-of select="count(//tei:biblStruct)"/></b></li>
                </ul>
                <ul>
                    <h2>Bibliographic features of volumes</h2>
                    <li>Uncut volumes: <xsl:value-of select="count(//@corresp[contains(., '#uncut')])"/></li>
                    <ul>
                        <li>owned/uncut: <xsl:value-of select="count(//tei:biblStruct[.//tei:note/@corresp[contains(., '#uncut')] and .[@corresp[contains(., 'owned')]]])"/></li>
                        <li>annotated/uncut: <xsl:value-of select="count(//tei:biblStruct[.//tei:note/@corresp[contains(., '#uncut')] and .[@corresp[contains(., 'annotated')]]])"/></li>
                        <li>corrected/uncut: <xsl:value-of select="count(//tei:biblStruct[.//tei:note/@corresp[contains(., '#uncut')] and .[@corresp[contains(., 'corrected')]]])"/></li>
                        <li>signed/uncut: <xsl:value-of select="count(//tei:biblStruct[.//tei:note/@corresp[contains(., '#uncut')] and .[@corresp[contains(., 'signed')]]])"/></li>
                        <li>presented by/uncut: <xsl:value-of select="count(//tei:biblStruct[.//tei:note/@corresp[contains(., '#uncut')] and .[@corresp[contains(., 'presented_by')]]])"/></li>
                        <li>presented to/uncut: <xsl:value-of select="count(//tei:biblStruct[.//tei:note/@corresp[contains(., '#uncut')] and .[.//tei:note/@corresp[contains(., '#presentation')]] and .[@corresp[contains(., 'owned')]]])"/></li>
                    </ul>
                    <li>Format all volumes: </li>
                    <ul>
                        <li>folio: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='folio']])"/></li>
                        <li>quarto: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='quarto']])"/></li>
                        <li>octavo: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='octavo']])"/></li>
                    </ul>
                    <li>Format of owned volumes: </li>
                    <ul>
                        <li>folio: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='folio'] and .[@corresp[contains(., 'owned')]]])"/></li>
                        <li>quarto: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='quarto'] and .[@corresp[contains(., 'owned')]]])"/></li>
                        <li>octavo: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='octavo'] and .[@corresp[contains(., 'owned')]]])"/></li>
                    </ul>
                    <li>Format of volumes presented <b>by</b> Swinburne: </li>
                    <ul>
                        <li>folio: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='folio'] and .[@corresp[contains(., 'presented_by')]]])"/></li>
                        <li>quarto: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='quarto'] and .[@corresp[contains(., 'presented_by')]]])"/></li>
                        <li>octavo: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='octavo'] and .[@corresp[contains(., 'presented_by')]]])"/></li>
                    </ul>
                    <li>Format of volumes presented <b>to</b> Swinburne: </li>
                    <ul>
                        <li>folio: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='folio'] and .[@corresp[contains(., 'owned')]] and .[descendant::tei:note/@corresp[contains(., '#presentation')]]])"/></li>
                        <li>quarto: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='quarto'] and .[@corresp[contains(., 'owned')]] and .[descendant::tei:note/@corresp[contains(., '#presentation')]]])"/></li>
                        <li>octavo: <xsl:value-of select="count(//tei:biblStruct[ancestor::tei:div[@type='size' and @n='octavo'] and .[@corresp[contains(., 'owned')]] and .[descendant::tei:note/@corresp[contains(., '#presentation')]]])"/></li>
                    </ul>
                    <li>Editions (owned)</li>
                    <ul>
                        <li>first: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'owned')] and .[descendant::tei:edition/@corresp[contains(., 'first_ed')]]])"/></li>
                        <li>second: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'owned')] and .[descendant::tei:edition/@corresp[contains(., 'sec_ed')]]])"/></li>
                        <li>deluxe: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'owned')] and .[descendant::tei:edition/@corresp[contains(., 'deluxe_ed')]]])"/></li>
                        <li>limited: <xsl:value-of select="count(//tei:biblStruct[@corresp[contains(., 'owned')] and .[descendant::tei:edition/@corresp[contains(., 'limited_ed')]]])"/></li>
                    </ul>
                    <li>Volume runs</li>
                    <ul>
                        <xsl:for-each-group select="//tei:biblStruct" group-by="number(.//tei:extent/tei:measure[@unit='volumes']/@quantity)">
                            <xsl:sort select="current-grouping-key()"/>
                            <li><xsl:value-of select="current-grouping-key()"/> volumes: <xsl:value-of select="count(current-group())"/></li>
                        </xsl:for-each-group>
                    </ul>

                </ul>
                <h2>Publication years</h2>
                <ul>
                    <xsl:for-each-group select="//tei:body//tei:biblStruct" group-by="number(substring(.//tei:imprint/tei:date/@when, 1, 4))">
                        <xsl:sort select="current-grouping-key()"/>
                        <li><xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/></li>
                    </xsl:for-each-group>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

