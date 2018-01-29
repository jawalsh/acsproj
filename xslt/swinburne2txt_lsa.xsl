<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"  xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <!-- xmlns="http://www.tei-c.org/ns/1.0"> -->
    
<xsl:output encoding="UTF-8" method="text" indent="no"/>
    
<xsl:template match="TEI/text">
<xsl:call-template name="header"/>
<xsl:apply-templates/>
</xsl:template>

    
    
<xsl:template match="l|item">
<xsl:variable name="line">
    <xsl:apply-templates />
</xsl:variable>
<xsl:value-of select="normalize-space($line)"/>
</xsl:template>
    
<xsl:template match="lg|p|head">
<xsl:apply-templates />
    <!--
<xsl:text>    
</xsl:text>
-->
</xsl:template>
    
    
    <!-- just for LSA -->
  <xsl:template match="pb">

      <xsl:param name="pagenum">
          <xsl:choose>
              <xsl:when test="starts-with(@n,'[')">
                  <xsl:value-of select="substring-after(substring-before(normalize-space(@n),']'),'[')"/>
              </xsl:when>
              <xsl:otherwise>
                  <xsl:value-of select="normalize-space(@n)"/>
              </xsl:otherwise>
          </xsl:choose>
      </xsl:param>
      
      <xsl:if test="not(@n) or normalize-space(@n) = ''">
          <xsl:message>Missing pb/@n.</xsl:message>
      </xsl:if>

      <xsl:value-of select="concat('PAGE[[ ',$pagenum,' ]]PAGE')"/>
      
  </xsl:template>
<!--    
<xsl:template match="lb">
<xsl:text>
</xsl:text>
</xsl:template>
-->
    
<xsl:template match="choice[@n = 'eol']">
    <xsl:apply-templates select="reg"/>
</xsl:template>

<xsl:template match="choice/reg|note[@type = 'dev']|note[@resp = 'jawalsh']"/>
<xsl:template match="*[contains(@rendition,'#suppress')]"/>
<xsl:template match="note[not(@place)]|note[@place='unspecified']"/>
<xsl:template match="teiHeader"/>
    
<xsl:template name="header">
    <xsl:value-of select="'DOC-ID: '"/><xsl:value-of select="/TEI/@xml:id"/>
<xsl:text>    
</xsl:text>
    <xsl:value-of select="'COLL: '"/>
    <xsl:choose>
        <xsl:when test="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/relatedItem[@type = 'original_collection']/biblStruct/monogr/title">
    <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/relatedItem[@type = 'original_collection']/biblStruct/monogr/title"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/biblStruct/monogr/title"/>
        </xsl:otherwise>
    </xsl:choose>
<xsl:text>    
</xsl:text>
    <xsl:value-of select="'TITLE: '"/><xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/>
<xsl:text>    
</xsl:text>
</xsl:template>

</xsl:stylesheet>
