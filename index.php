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
				
			$works = array('sepoys' => 'The Sepoys', 'pearls' => 'The String of Pearls');

			foreach ($works as $key => $title) {
				print '<p><a class="issue-link" href="work.php?work='.$key.'">'.$title.'</a></p>';
			
			}
			
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

