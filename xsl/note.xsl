<!-- 
Rymer
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exist="http://exist.sourceforge.net/NS/exist" version="1.0">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:variable name="file"><xsl:value-of select="//filename"/></xsl:variable>
    <xsl:template match="//filename"/>
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
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="emph">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    <xsl:template match="note">
        <div>
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
			<xsl:apply-templates/>
		</div>
    </xsl:template>	
</xsl:stylesheet>