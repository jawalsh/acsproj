<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
    <!-- change dataRoot parameter to your local file path -->
    <xsl:param name="dataRoot" as="xs:string">
        <xsl:value-of select="'/Users/jawalsh/development/swinburne/data/'"/>
    </xsl:param>
    <!-- ***************************************************************************
        Global variables:
        
        mdDir       Directory where the Metadata files are located. (Not sure if we need)
        
        outDir      Directory for output files. (CHANGE TO LOCAL OUTPUT DIRECTORY)
        
        outFileExt  String to add to the end of file to designate new file name
                    and extension. (CHANGE TO USE A DIFFERENT NAME AND EXT FOR OUTPUT FILE)
                    
        **************************************************************************** -->
    <xsl:param name="mdDir" select="concat('/Users/jawalsh/development/swinburne/data','/')"/>
    <xsl:param name="outDir" select="concat('/Users/jawalsh/development/swinburne/output','/')"/>
    <xsl:param name="outFileExt" select="'.xml'"/>
    <!-- match root element and process relevent text and div elements -->
    <xsl:template match="/">
        <xsl:apply-templates
            select="//text[index[@indexName = 'text']]|//div[index[@indexName = 'text']]"
        />
    </xsl:template>
    <!-- template for relevant text and div elements -->
    <xsl:template
        match="text[index[@indexName = 'text']]|div[index[@indexName = 'text']]">
        <!-- grab id of appropriate element -->
        
        <!-- Grabs relevant component ID.  In the case of the /TEI/text element, this comes from /TEI/@xml:id. -->
        <xsl:variable name="componentId">
            <xsl:choose>
                <xsl:when test="@xml:id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:when>
                <xsl:when test="not(@xml:id) and parent::TEI">
                    <xsl:value-of select="/TEI/@xml:id"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>
                        <xsl:value-of select="'MESSAGE: Component does not have an @xml:id!'"/>
                    </xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!-- generate path to metdata doc -->
        <xsl:variable name="mdDoc">
            <xsl:copy-of select="document(concat($dataRoot,$componentId,'-md.xml'))"/>
        </xsl:variable>

        <!-- generate path to output document -->
        <xsl:variable name="outputFile">
            <xsl:value-of select="concat($outDir,$componentId,$outFileExt)"/>
        </xsl:variable>
        <!-- output results to output document -->
        <xsl:result-document method="xml" encoding="utf-8" indent="no" href="{$outputFile}">
            <xsl:message select="$outputFile"/>
            <xsl:processing-instruction name="oxygen"> RNGSchema="swinburne.rnc" type="compact" </xsl:processing-instruction>
            <TEI>
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="$componentId"/>
                </xsl:attribute>
                <teiHeader>
                    <fileDesc>
                        <!-- copy in desired children from metadata document -->
                        <xsl:copy-of select="$mdDoc/TEI/teiHeader/fileDesc/titleStmt"/>
                        <xsl:copy-of select="$mdDoc/TEI/teiHeader/fileDesc/publicationStmt"/>
                        <xsl:copy-of select="$mdDoc/TEI/teiHeader/fileDesc/seriesStmt"/>
                        <!-- copy in the required biblStruct or msDesc from metadata document -->
                        <sourceDesc>
                            <xsl:apply-templates select="$mdDoc/TEI//*[@xml:id = concat($componentId,'-bibl')]" mode="combo-bibl">
                                <xsl:with-param name="mdDoc" select="$mdDoc"/>
                                <xsl:with-param name="componentId" select="$componentId"/>
                            </xsl:apply-templates>
                            <!--
                            <xsl:copy-of
                                select="$mdDoc/TEI//*[@xml:id = concat($componentId,'-bibl')]"/>
                                -->
                        </sourceDesc>
                    </fileDesc>
                    <xsl:copy-of select="$mdDoc/TEI/teiHeader/encodingDesc"/>
                    <xsl:copy-of select="$mdDoc/TEI/teiHeader/profileDesc"/>
                </teiHeader>
                <!-- generate text element, different behaviors for component text vs. component div. -->
                <xsl:choose>
                    <xsl:when test="name() = 'text'">
                        <text>
                            <xsl:attribute name="xml:id" select="concat(@xml:id,'-content')"/>
                            <xsl:copy-of select="@*[not(name() = 'xml:id')]"/>
                            
                                <xsl:apply-templates select="child::node()"/>
                            <xsl:if test="not(./back) and (//ptr[@type = 'note' and (id(substring-after(@target,'#'))[not(ancestor::text[@xml:id = $componentId])])])">
                                <back>
                                    <div n="[notes]">
                                <xsl:call-template name="collect-notes">
                                    <xsl:with-param name="componentId" select="$componentId"/>
                                </xsl:call-template>
                                    </div>
                                </back>
                            </xsl:if>
                        </text>
                    </xsl:when>
                    <xsl:when test="name() = 'div'">
                        <text>
                            <body>
                                <div>
                                    <xsl:attribute name="xml:id" select="concat(@xml:id,'-content')"/>
                                    <xsl:copy-of select="@*[not(name() = 'xml:id')]"/>
                                    <xsl:apply-templates select="child::node()"/>
                                    <xsl:call-template name="collect-notes">
                                        <xsl:with-param name="componentId" select="$componentId"/>
                                    </xsl:call-template>
                                </div>
                            </body>
                            <xsl:if test="//ptr[@type = 'note' and (id(substring-after(@target,'#'))[not(ancestor::node()[@xml:id = $componentId])])]">
                                <back>
                                    <xsl:call-template name="collect-notes">
                                        <xsl:with-param name="componentId" select="$componentId"/>
                                    </xsl:call-template>
                                </back>
                            </xsl:if>
                        </text>
                    </xsl:when>
                </xsl:choose>
            </TEI>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="back">
        <xsl:param name="componentId" select="ancestor::text[index[@indexName = 'text']]/@xml:id"/>
        <back>
                <xsl:copy-of select="@*"/>
                <xsl:apply-templates select="child::node()"/>
            <xsl:if test="//ptr[@type = 'note' and (id(substring-after(@target,'#'))[not(ancestor::node()[@xml:id = $componentId])])]">
                <div n="[notes]">
                    <xsl:call-template name="collect-notes">
                        <xsl:with-param name="componentId" select="$componentId"/>
                    </xsl:call-template>
                </div>
            </xsl:if>
        </back>
    </xsl:template>
    
        
    
    <xsl:template match="@*|node()"> <!-- copy select elements -->
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="biblStruct" mode="combo-bibl">
        <xsl:param name="mdDoc"/>
        <xsl:param name="componentId"/>
        <biblStruct>
            <xsl:copy-of select="analytic"/>
            <xsl:copy-of select="monogr"/>
            <xsl:copy-of select="idno"/>
            <xsl:if test="$mdDoc/TEI//biblStruct[@n = 'original_collection'] and (not($mdDoc/TEI//biblStruct[@n = 'original_collection']/@xml:id) or $mdDoc/TEI//biblStruct[@n = 'original_collection']/@xml:id != concat($componentId,'-bibl'))">
                <relatedItem type="original_collection">
                    <xsl:copy-of select="$mdDoc/TEI//biblStruct[@n = 'original_collection']"/>
                    <!--
                    <bibl>
                        <title><xsl:apply-templates select="//biblStruct[@n = 'original_collection']/monogr/title"/></title><xsl:copy-of select="$mdDoc/TEI//date[@xml:id = 'sort_date']"/></bibl>
                    -->
                </relatedItem>
            </xsl:if>
        </biblStruct>
    </xsl:template>
    
    <xsl:template match="ptr[not(@type)][starts-with(@target,'#')]">
        <xsl:param name="target" select="substring-after(@target,'#')"/>
        <xsl:variable name="componentId" select="ancestor::*[index[@indexName = 'text']][1]/@xml:id"/>
        <xsl:message select="concat('$componentId: ',$componentId)"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
        <xsl:if test="//*[@xml:id = $target][not(ancestor::*[@xml:id = $componentId])]">
            <note type="external" rend="display:none;">
                <note>
                    <xsl:copy-of select="//*[@xml:id = $target]/@*"/>
                    <xsl:copy-of select="//*[@xml:id = $target]/preceding::pb[1]"/>
                    <xsl:apply-templates select="//*[@xml:id = $target]/child::*"/>
                </note>
            </note>
        </xsl:if>
        <!--
        <xsl:if test="*[@xml:id = '$target'][not(ancestor::*[@xml:id = $componentId]">
            
        </xsl:if>
        -->
    </xsl:template>
    
    <!-- works -->
    <!--
    <xsl:template name="collect-notes">
        <xsl:param name="componentId"/>
        <xsl:variable name="component">
            <xsl:copy-of select="//*[@xml:id = $componentId]"/>
        </xsl:variable>
        
        <div n="[notes]">
            <xsl:for-each select=".//ptr[@type = 'note']">
                <xsl:variable name="ptrId" select="substring-after(@target,'#')"/>
                 <xsl:if test="id($ptrId)[not(ancestor::node()[@xml:id = $componentId])]">               
                <xsl:message select="concat('IDENTIFIED POINTER: @target = ', @target)"/>
                <xsl:apply-templates select="id($ptrId)"/>
                 </xsl:if>
            </xsl:for-each>
        </div>
        </xsl:template>
    -->
    
    <xsl:template name="collect-notes">
        <xsl:param name="componentId"/>
        <xsl:variable name="component">
            <xsl:copy-of select="//*[@xml:id = $componentId]"/>
        </xsl:variable>
        
        <xsl:message select="concat('Component ID: ', $componentId)"/>
        
        <xsl:if test="//ptr[@type = 'note' and (id(substring-after(@target,'#'))[not(ancestor::node()[@xml:id = $componentId])])]">
            <xsl:for-each select=".//ptr[@type = 'note']">
                <xsl:variable name="ptrId" select="substring-after(@target,'#')"/>
                <xsl:if test="id($ptrId)[not(ancestor::node()[@xml:id = $componentId])]">               
                    <xsl:message select="concat('IDENTIFIED POINTER: @target = ', @target)"/>
                    <xsl:apply-templates select="id($ptrId)" mode="collect-notes"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
        
    </xsl:template>
    
    <xsl:template match="note" mode="collect-notes">
        <note>
        <xsl:copy-of select="@*"/>
        <xsl:if test="not(child::pb)">
            <xsl:apply-templates select="preceding::pb[1]"/>
        </xsl:if>
        <xsl:apply-templates select="child::node()"/>
        </note>
    </xsl:template>
    
    
    
    <!--
        
    <xsl:template name="external-notes">
        <xsl:variable name="notes" select="//ptr[not(@type)]//@target"/>-->
        
        
                
            
</xsl:stylesheet>
