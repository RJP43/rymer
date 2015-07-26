<?php
   			$root = root();

			function cmp(array $a, array $b) {
				if ($a['num'] == 'frontmatter') {
					return -1;
				} else if($b['num'] == 'frontmatter') {
					return 1;
				} else {
					return strcmp($a['file'], $b['file']);
				}
			}

			function root () {
				if ($_SERVER['SERVER_NAME'] == 'localhost') {
					return '/rymer/';
				} else {
					return '/';
				}
			}
?>
