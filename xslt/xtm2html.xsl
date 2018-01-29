<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.topicmaps.org/xtm/">
    <xsl:output method="xhtml" doctype-public="-//W3C//DTD XHTML 1.1//EN"
        doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>
    <xsl:param name="tm_title">
        <xsl:value-of select="'Swinburne Topic Map'"/>
    </xsl:param>
    <xsl:template match="/">
        <html>
            <head>
                <style type="text/css"> 
body { font-family: verdana, sans-serif; font-size: small; }

div.topic, li {
width: 30em; /*298px;*/
margin: 2em;
padding: .5em 1em .5em 1em;
-webkit-border-radius: 1em;
-moz-border-radius: 1em;
border-radius: 1em;
background-color: #c3d0d4;

}

div.topic h2{
color: #800000;
}

h1 { font-size: 110%; }
h2 { font-size: 105%; }
h3 { font-size: 100%; margin-bottom: .25em;}

div div { margin-left: 2em; }

a.bracket:before {
content: "\003C";
}

a.bracket:after {
content: "\003E";
}

a:link, a:visited {
text-decoration: none;
}

a:hover {
text-decoration: underline;
}
                </style>
                <title>
                    <xsl:value-of select="$tm_title"/>
                </title>
            </head>
            <body>
                <div id="contents">
                    <ol>
                        <li><a href="#places">Events</a></li>
                        <li><a href="#people">People</a></li>
                        <li><a href="#places">Places</a></li>
                        <li><a href="#geog">Geographic Features</a></li>
                        
                    </ol>
                </div>
                
                            
                <!--
                <xsl:apply-templates select="//topic">
                    <xsl:sort select="normalize-space(name/value)"/>
                    <xsl:sort select="@id"/>
                </xsl:apply-templates>
                -->
                <xsl:call-template name="events"/>
                <xsl:call-template name="people"/>
                <xsl:call-template name="places"/>
                <xsl:call-template name="geog"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="people">
        <div id="people">
           <h1>People</h1>
        <xsl:for-each select="//topic[instanceOf/topicRef[@href='#person']]">
            <xsl:sort select="normalize-space(name/value)"/>
            <xsl:sort select="@id"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="geog">
        <div id="geog">
            <h1>Geographic Features</h1>
            <xsl:for-each select="//topic[instanceOf/topicRef[@href='#geog']]">
                <xsl:sort select="normalize-space(name/value)"/>
                <xsl:sort select="@id"/>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="events">
        <div id="events">
            <h1>Events</h1>
            <xsl:for-each select="//topic[instanceOf/topicRef[@href='#event']]">
                <xsl:sort select="normalize-space(name/value)"/>
                <xsl:sort select="@id"/>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template name="places">
        <div id="places">
            <h1>Places</h1>
            <xsl:for-each select="//topic[instanceOf/topicRef[@href='#place']]">
                <xsl:sort select="normalize-space(name/value)"/>
                <xsl:sort select="@id"/>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="topic">
        <div class="topic">
            <h2>
                <xsl:choose>
                    <xsl:when test="not(name)">
                        <xsl:text>[No Name]</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="name/value"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="@id"/>
                <xsl:text>)</xsl:text>
            </h2>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="occurrence">
        <xsl:param name="type_id">
            <xsl:value-of select="substring-after(type/topicRef/@href,'#')"/>
        </xsl:param>
        <xsl:param name="type_label">
            <xsl:apply-templates select="//topic[@id = $type_id]/name/value"/>
        </xsl:param>
        <div class="occurrence">
            <h3>
                <xsl:value-of select="$type_label"/>
            </h3>

            <xsl:apply-templates select="resourceData"/>
            <xsl:apply-templates select="resourceRef"/>
        </div>
    </xsl:template>

    <xsl:template match="name">
        <xsl:if test="variant">
            <div class="variant_names">
                <h3>Variant Names</h3>
                    <xsl:for-each select="variant">
                        <xsl:value-of select="resourceData"/>
                        <xsl:if test="position() != last()">
                            <xsl:value-of select="'; '"/>
                        </xsl:if>
                    </xsl:for-each>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="resourceRef">
            <a href="{@href}">
                <xsl:value-of select="@href"/>
            </a>
    </xsl:template>


</xsl:stylesheet>
