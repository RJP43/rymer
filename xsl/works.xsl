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
        <xsl:apply-templates/>
    </xsl:template>
	<xsl:template match="teiHeader" />
    <xsl:template match="text">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="div">
				<div>
					<xsl:apply-templates/>
				</div>
    </xsl:template>
    <xsl:template match="title">
    	<xsl:choose>
    		<xsl:when test="@corresp">
				<p>
					<a>
						<xsl:attribute name="class">issue-link</xsl:attribute>
						<xsl:attribute name="href">work.php?work=<xsl:value-of select="@corresp"/></xsl:attribute>
						<xsl:apply-templates/>
					</a>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p>
						<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
    </xsl:template>
</xsl:stylesheet>