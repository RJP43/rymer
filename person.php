<!DOCTYPE html>
<html>
	<?php
	require('include/functions.php');
	
	$fileExists = true;
	$file = '';
	$series = '';
	$fileSplit = '';
	$title = '';
	$pt = array();
	$pt_post = '';
	
	if($_GET["file"]) {
		$file = $_GET["file"];
		$fileParts = explode('.', $file);
		$series = $fileParts[0];
		if(simplexml_load_file('xml/'.$file)) {			
			$FullXML = simplexml_load_file('xml/'.$file);
			$XMLtitle = $FullXML->xpath('//teiHeader/fileDesc/titleStmt/title');
			$title = $XMLtitle[0];
		
			$pt[] = $title;
		} else {
			$fileExists = false;
		}
	}
	
	require('include/head.php');
	?>
	<body>
			<div id="person">
					<?php
					if($fileExists) {
						# LOAD XML FILE 
						$XML = new DOMDocument(); 
						$XML->load( 'xml/'.$file );
						
						# START XSLT 
						$xslt = new XSLTProcessor(); 
						$XSL = new DOMDocument(); 
						$XSL->load( 'xsl/person.xsl'); 
						$xslt->importStylesheet( $XSL ); 
						#PRINT 
						print $xslt->transformToXML( $XML ); 

					} else {
			?>
						<h3>File Not Found</h3>
						<p>Return to <a href="/">home page</a>.</p>
			<?php
			}			
			?>
		</div> <!-- #person -->
	</body>
</html>
