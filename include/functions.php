<?php
			function cmp(array $a, array $b) {
				if ($a['num'] == 'frontmatter') {
					return -1;
				} else if($b['num'] == 'frontmatter') {
					return 1;
				} else {
					return strcmp($a['file'], $b['file']);
				}
			}

?>
