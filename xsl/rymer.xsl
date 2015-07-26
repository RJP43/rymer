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
							<xsl:if test="$series != 'context'">
								<xsl:apply-templates select="//biblStruct"/>
							</xsl:if>
                        </div>
                    </div>
    </xsl:template>
	<xsl:variable name="series" select="//teiHeader/fileDesc/seriesStmt/idno" />
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
    <xsl:template match="titleStmt//title" />
    <xsl:template match="titleStmt//editor">
    	<xsl:choose>
    		<xsl:when test="@type='technical'">
		        <div>
        		    <xsl:attribute name="class">header-technical-editor</xsl:attribute>
        		    <span class="technical-editor-label">Technical Editor</span>
        		    &#183;
        		    <xsl:apply-templates/>
        		</div>
        	</xsl:when>
        	<xsl:otherwise>
		        <div>
        		    <xsl:attribute name="class">header-editor</xsl:attribute>
        		    <span class="editor-label">Editor</span>
        		    &#183;
        		    <xsl:apply-templates/>
        		</div>
        	</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="titleStmt//author">
        <div>
            <xsl:attribute name="class">header-author</xsl:attribute>
            <span class="author-label">Author</span>
            &#183;
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="monogr//title">
        <div>
            <xsl:attribute name="class">monograph-title</xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="publicationStmt//publisher"/>
    <xsl:template match="monogr//title[@level='j']" />
    <xsl:template match="pubPlace"/>
    <xsl:template match="p">
        <p>
                    <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="encodingDesc"/>
    <xsl:template match="figure">
    	<xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="figure/graphic">
							<a>	
                                <xsl:attribute name="href">
                                    <xsl:value-of select="@url"/>
                                </xsl:attribute>
                                <xsl:attribute name="class">fancybox</xsl:attribute>
                                <xsl:if test="ancestor::figure/figDesc">
                                	<xsl:attribute name="title">
                                    	<xsl:value-of select="ancestor::figure/figDesc"/>
                                	</xsl:attribute>
                                </xsl:if>
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
    <xsl:template match="figure/figDesc"/>
    <xsl:template match="emph">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    <xsl:template match="persName[@corresp]">
    	<xsl:variable name="corresp"><xsl:value-of select="@corresp"/></xsl:variable>
    	<xsl:variable name="personography"><xsl:value-of select="$series"/>.personography.xml</xsl:variable>
    	<xsl:variable name="file"><xsl:value-of select="substring-before($corresp, '#')"/></xsl:variable>
    	<xsl:choose>
    		<xsl:when test="$file = $personography">
		    	<xsl:variable name="person"><xsl:value-of select="substring-after($corresp, '#')"/></xsl:variable>
		        <a>
		            <xsl:attribute name="class">person-link</xsl:attribute>
        	    	<xsl:attribute name="href">person.php?file=<xsl:value-of select="$file"/>&amp;p=<xsl:value-of select="$person"/></xsl:attribute>
        	    	<xsl:apply-templates/>
        		</a>
        	</xsl:when>
        	<xsl:otherwise>
        		<xsl:call-template name="note-link" />
        	</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="roleName[@corresp]">
    	<xsl:call-template name="note-link" />
    </xsl:template>
    <xsl:template match="orgName[@corresp]">
    	<xsl:call-template name="note-link" />
    </xsl:template>
    <xsl:template match="foreign[@corresp]">
    	<xsl:call-template name="note-link" />
    </xsl:template>
    <xsl:template match="distinct[@corresp]">
    	<xsl:call-template name="note-link" />
    </xsl:template>
    <xsl:template match="placeName[@corresp]">
    	<xsl:call-template name="note-link" />
    </xsl:template>
    <xsl:template match="addName[@corresp]">
    	<xsl:call-template name="note-link" />
    </xsl:template>
    <xsl:template name="note-link">
        <xsl:variable name="corresp"><xsl:value-of select="@corresp"/></xsl:variable>
    	<xsl:variable name="file"><xsl:value-of select="substring-before($corresp, '#')"/></xsl:variable>
    	<xsl:variable name="note"><xsl:value-of select="substring-after($corresp, '#')"/></xsl:variable>
        <a>
            <xsl:attribute name="class">note-link</xsl:attribute>
            <xsl:attribute name="href">note.php?file=<xsl:value-of select="$file"/>&amp;n=<xsl:value-of select="$note"/></xsl:attribute>
            <xsl:apply-templates/>
        </a>
	</xsl:template>
	<xsl:template match="biblStruct">
		<xsl:variable name="prev"><xsl:value-of select="@prev"/></xsl:variable>
    	<xsl:variable name="prevFile"><xsl:value-of select="substring-before($prev, '.xml#')"/></xsl:variable>
    	<!--<xsl:variable name="prevLabel"><xsl:value-of select="substring-after($prev, '#installment')"/></xsl:variable>-->
		<xsl:variable name="current"><xsl:value-of select="@xml:id"/></xsl:variable>
    	<xsl:variable name="currentLabel"><xsl:value-of select="substring-after($current, 'installment')"/></xsl:variable>
		<xsl:variable name="next"><xsl:value-of select="@next"/></xsl:variable>
    	<xsl:variable name="nextFile"><xsl:value-of select="substring-before($next, '.xml#')"/></xsl:variable>
    	<!--<xsl:variable name="nextLabel"><xsl:value-of select="substring-after($next, '#installment')"/></xsl:variable>-->
		<div>
			<xsl:attribute name="class">prev-next-nav</xsl:attribute>
			<xsl:if test="@prev">
				<a>
					<xsl:attribute name="class">prev-link</xsl:attribute>
					<xsl:attribute name="href">installment.php?file=<xsl:value-of select="$prevFile"/></xsl:attribute>
					&#171; Previous
				</a>
				&#183;
			</xsl:if>
    		<xsl:choose>
    			<xsl:when test="$current = 'frontmatter'">
					<span>
						<xsl:attribute name="class">current-installment</xsl:attribute>
						Front Matter
					</span>
				</xsl:when>
    			<xsl:when test="$current = 'backmatter'">
					<span>
						<xsl:attribute name="class">current-installment</xsl:attribute>
						Back Matter
					</span>
				</xsl:when>
    			<xsl:when test="$current = 'personography'">
					<span>
						<xsl:attribute name="class">current-installment</xsl:attribute>
						Personography
					</span>
				</xsl:when>
    			<xsl:when test="$current = 'about'">
					<span>
						<xsl:attribute name="class">current-installment</xsl:attribute>
						About
					</span>
				</xsl:when>
    			<xsl:otherwise>
					<span>
						<xsl:attribute name="class">current-installment</xsl:attribute>
						Installment <xsl:value-of select="$currentLabel"/>
					</span>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@next">
				&#183;
				<a>
					<xsl:attribute name="class">next-link</xsl:attribute>
					<xsl:attribute name="href">installment.php?file=<xsl:value-of select="$nextFile"/></xsl:attribute>
					Next &#187;
				</a>
			</xsl:if>	
		</div>
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>