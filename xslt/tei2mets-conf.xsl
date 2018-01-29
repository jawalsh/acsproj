<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mets="http://www.loc.gov/METS/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    version="2.0">
    
    <xsl:param name="creator" as="xs:string">
        <xsl:value-of select="'John A. Walsh'"/>
    </xsl:param>
    <xsl:param name="imgPath" select="'http://purl.dlib.indiana.edu/iudl/swinburne/'"/>
       
    
    <xsl:param name="imgform">
        <tei:list xml:id="imgform">
            <tei:item n="archive">
                <tei:list>
                    <tei:item n="extension"/>
                    <tei:item n="mimetype"><xsl:value-of select="'image/tif'"/></tei:item>
                    <tei:item n="loctype"><xsl:value-of select="'URL'"/></tei:item>
                    <tei:item n="urlprefix"><xsl:value-of select="concat($imgPath,'archive/')"/></tei:item>
                </tei:list>
            </tei:item>
            <tei:item n="screen">
                <tei:list>
                    <tei:item n="extension"/>
                    <tei:item n="mimetype"><xsl:value-of select="'image/jpeg'"/></tei:item>
                    <tei:item n="loctype"><xsl:value-of select="'URL'"/></tei:item>
                    <tei:item n="urlprefix"><xsl:value-of select="concat($imgPath,'screen/')"/></tei:item>
                </tei:list>
            </tei:item>
            <tei:item n="large">
                <tei:list>
                    <tei:item n="extension"/>
                    <tei:item n="mimetype"><xsl:value-of select="'image/jpeg'"/></tei:item>
                    <tei:item n="loctype"><xsl:value-of select="'URL'"/></tei:item>
                    <tei:item n="urlprefix"><xsl:value-of select="concat($imgPath,'large/')"/></tei:item>
                </tei:list>
            </tei:item>
            <tei:item n="thumbnail">
                <tei:item n="extension"/>
                <tei:item n="mimetype"><xsl:value-of select="'image/jpeg'"/></tei:item>
                <tei:item n="loctype"><xsl:value-of select="'URL'"/></tei:item>
                <tei:item n="urlprefix"><xsl:value-of select="concat($imgPath,'thumbnail/')"/></tei:item>
            </tei:item>
        </tei:list>
    </xsl:param>
    
    
    
    
    
    <!--
    <xsl:param name="enableMouseoverNotes" as="xs:boolean"><xsl:value-of select="true()"/></xsl:param>
    
    <xsl:param name="dataRoot" as="xs:string">
        <xsl:value-of select="'/Users/jawalsh/development/swinburne/data/'"/>
    </xsl:param>
    -->
    

</xsl:stylesheet>
