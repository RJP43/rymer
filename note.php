<!DOCTYPE html>
<html>
	<?php
	require('include/functions.php');
	
	$fileExists = true;
	$file = '';
	$note = '';
	$series = '';
	$fileSplit = '';
	$title = '';
	$pt = array();
	$pt_post = '';
	
	if($_GET["file"] && $_GET["n"]) {
		$file = $_GET["file"];
		$note = $_GET["n"];
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
	
	?>
					<?php
					if($fileExists) {
						# LOAD XML FILE 
						$XML = new DOMDocument(); 
						$XML->load( 'xml/'.$file );
						
						# Extract only the note indicated
						$TEI = $XML->documentElement;
						$notes = $TEI->getElementsByTagName('note');
						
						$XMLnote = new DOMDocument;
						
						$i = 0;
						foreach($notes as $nt) { 
						    $ntID = $nt->getAttribute('xml:id'); 
						    
						    if($ntID == $note) {
								$ntString = $notes->item($i)->ownerDocument->saveXML($notes->item($i));
								$ntString = str_replace('</note>', '<filename>'.$file.'</filename></note>', $ntString);

								$XMLnote->loadXML($ntString);
						    }
						    
						    $i = $i + 1;
						} 
						
						# START XSLT 
						$xslt = new XSLTProcessor(); 
						$XSL = new DOMDocument(); 
						$XSL->load( 'xsl/note.xsl'); 
						$xslt->importStylesheet( $XSL ); 
						#PRINT 
						print $xslt->transformToXML( $XMLnote );

					} else {
			?>
						<h3>Note Not Found</h3>
			<?php
			}			
			?>
</html>
