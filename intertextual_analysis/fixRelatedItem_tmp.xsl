<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all">
	<xsl:output encoding="UTF-8"/>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="@*|node()">
		<!-- copy select elements -->
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="relatedItem[not(preceding-sibling::relatedItem) and not(following-sibling::relatedItem)]">
		<tei:relatedItem type="{@type}" target="{@target}"/>
	</xsl:template>

</xsl:stylesheet>
