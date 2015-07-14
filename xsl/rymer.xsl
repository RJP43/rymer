<!-- 
Rymer
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exist="http://exist.sourceforge.net/NS/exist" version="1.0">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="TEI">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="/">
                    <div id="main" class="main-doc">
                        <div id="core">
							<xsl:apply-templates/>
                        </div>
                    </div>
    </xsl:template>
	<xsl:template match="//teiHeader/fileDesc/seriesStmt/idno" />
    <xsl:template match="text">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="div">
				<div>
					<xsl:apply-templates/>
				</div>
    </xsl:template>
    <xsl:template match="pb">
        <span class="page-attributes">
            <span class="pb-holder">
                <a class="pb">
                    <xsl:attribute name="id">
                        <xsl:text>p</xsl:text>
                        <xsl:value-of select="@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="title">Page <xsl:value-of select="@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="href">#p<xsl:value-of select="@n"/>
                    </xsl:attribute>
                    <span class="pagelabel">begin page </span>
                    <xsl:value-of select="@n"/>
                </a>
            </span>
            <span class="clear"/>
        </span>
    </xsl:template>
    <xsl:template match="head">
        <h3>
            <xsl:if test="@xml:id">
                <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>
    <xsl:template match="title">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="p">
        <p>
                    <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="encodingDesc"/>
    <xsl:template match="figure/graphic">
							<a>	
                                <xsl:attribute name="href">
                                    <xsl:value-of select="@url"/>
                                </xsl:attribute>
							    <img>
									<xsl:attribute name="src">
										<xsl:value-of select="@url"/>
									</xsl:attribute>
								    <xsl:attribute name="width">
								        500
								    </xsl:attribute>
								</img>
							</a>    
    </xsl:template>
    <xsl:template match="emph">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    <xsl:template match="persName">
    	<xsl:variable name="corresp"><xsl:value-of select="@corresp"/></xsl:variable>
    	<xsl:variable name="file"><xsl:value-of select="substring-before($corresp, '#')"/></xsl:variable>
    	<xsl:variable name="person"><xsl:value-of select="substring-after($corresp, '#')"/></xsl:variable>
        <a>
            <xsl:attribute name="class">person-link</xsl:attribute>
            <xsl:attribute name="href">person.php?file=<xsl:value-of select="$file"/>&amp;p=<xsl:value-of select="$person"/></xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
</xsl:stylesheet>