<!DOCTYPE html>
<html>
	<?php
	require('include/functions.php');
	
	$fileExists = true;
	$file = '';
	$series = '';
	$fileSplit = '';
	//$date = '';
	$title = '';
	$pt = array();
	$pt_post = '';
	
	if($_GET["file"] && simplexml_load_file('xml/'.$_GET["file"].'.xml')) {
		$file = $_GET["file"];
		
		$fileParts = explode('.', $file);
		$series = $fileParts[0];
		$fileSplit = (count($fileParts) > 2) ? $fileParts[1].'.'.$fileParts[2] : $fileParts[1];
			
		$FullXML = simplexml_load_file('xml/'.$file.'.xml');
		//$XMLdate = $FullXML->xpath('//editionStmt/edition');
		//$date = $XMLdate[0];
		$XMLtitle = $FullXML->xpath('//teiHeader/fileDesc/titleStmt/title');
		$title = $XMLtitle[0];
		
		$pt[] = $title;
	} else {
		$fileExists = false;
	}
	
	require('include/head.php');
	?>
	<body>
		<?php include_once("include/analyticstracking.php") ?>
        <div id="outer" class="doc-page">
			<?php
			require('include/header.php');
			?>
			<div id="content">
				<div id="content-inner">
					<?php
					if($fileExists) {
					?>
					<div id="issue-heading">
						<div class="issue-heading-inner">
							<h1><a href="work.php?work=<?php echo $series; ?>"><?php echo $title; ?></a></h1>
						</div>
					</div>
					<?php
					
						# LOAD XML FILE 
						$XML = new DOMDocument(); 
						$XML->load( 'xml/'.$file.'.xml' );

					
						# START XSLT 
						$xslt = new XSLTProcessor(); 
						$XSL = new DOMDocument(); 
						$XSL->load( 'xsl/rymer.xsl'); 
						$xslt->importStylesheet( $XSL ); 
						#PRINT 
						print $xslt->transformToXML( $XML ); 

					} else {
			?>
						<div id="issue-heading">
							<div class="issue-heading-inner">
								<h1>File Not Found</h1>
							</div>
						</div>
						<div id="main">
							<div id="core">
								<p>Return to <a href="/">home page</a>.</p>
							</div>
						</div>
			<?php
			}
			
			include('include/footer.php');
			?>
				</div> <!-- #content-inner -->
			</div> <!-- #content -->
		</div> <!-- #outer -->
	</body>
</html>
