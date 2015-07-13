<!DOCTYPE html>
<html>
	<?php
	require('include/functions.php');
	
	$fileExists = true;
	$file = '';
	$person = '';
	$series = '';
	$fileSplit = '';
	$title = '';
	$pt = array();
	$pt_post = '';
	
	if($_GET["file"] && $_GET["p"]) {
		$file = $_GET["file"];
		$person = $_GET["p"];
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
	} else {
		$fileExists = false;
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
						
						# Remove all persons but the one indicated
						$TEI = $XML->documentElement;
						$persons = $TEI->getElementsByTagName('person');
						
						$XMLperson = new DOMDocument;
						
						$i = 0;
						foreach($persons as $pers) { 
						    $persID = $pers->getAttribute('xml:id'); 
						    
						    if($persID == $person) {
								$persString = $persons->item($i)->ownerDocument->saveXML($persons->item($i));

								$XMLperson->loadXML($persString);
						    }
						    
						    $i = $i + 1;
						} 
						
						# START XSLT 
						$xslt = new XSLTProcessor(); 
						$XSL = new DOMDocument(); 
						$XSL->load( 'xsl/person.xsl'); 
						$xslt->importStylesheet( $XSL ); 
						#PRINT 
						print $xslt->transformToXML( $XMLperson ); // $XMLperson

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
