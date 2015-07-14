<!DOCTYPE html>
<html>
	<?php
	require('include/functions.php');
	$title = 'List of Works';

	$pt = array($title);
	$pt_post = '';

	require('include/head.php');
	?>
	<body>
        <div id="outer">
			<?php
			require('include/header.php');
			?>
				
			<div id="content">
				<div id="content-inner">
					<div id="issue-heading">
						<div class="issue-heading-inner">
							<h1><?php echo $title; ?></h1>
						</div>
					</div>
					<div id="main">
						<div id="articles-reviews-index">
			<?php
			
						# LOAD XML FILE 
						$XML = new DOMDocument(); 
						$XML->load( 'xml/works.xml' );
						# START XSLT 
						$xslt = new XSLTProcessor(); 
						$XSL = new DOMDocument(); 
						$XSL->load( 'xsl/works.xsl'); 
						$xslt->importStylesheet( $XSL ); 
						#PRINT 
						print $xslt->transformToXML( $XML ); 

			?>
						</div> <!-- #articles-reviews-index -->
					</div> <!-- #main -->
					<?php
					include('include/footer.php');
					?>
				</div> <!-- #content-inner -->
			</div> <!-- #content -->
		</div> <!-- #outer -->
	</body>
</html>

