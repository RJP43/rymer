var persNote = 0;

$(window).ready(function(){
});

$(window).load(function(){		
	$('a[class=person-link]').click(function(e){
		e.preventDefault();
		var $plink = $(this);

		if(typeof $plink.attr('id') !== 'undefined') {
			var pnoteid = $plink.attr('id').substr(4);
			$pnote = $( "#"+pnoteid );
			if($pnote.attr('style') == 'undefined' || $pnote.attr('style') == 'display:none;') {
				$pnote.attr('style', 'display:block;');
			} else {
				$pnote.attr('style', 'display:none;');
			}
		} else {
			$plink.attr('id', 'ref-pers-'+persNote);
			
			var insideNote = $(this).closest('.pers-note').length;
			if(insideNote) {
				var $plinkAncestor = $(this).closest('.pers-note');
				$plinkAncestor.after('<span class="pers-note" id="pers-'+persNote+'"></span>');
			} else {
				$plink.after('<span class="pers-note" id="pers-'+persNote+'"></span>');
			}
			
			$( "#pers-"+persNote ).load ($plink.attr('href'));
			persNote = persNote + 1;
			return false;
		}
	});
});

