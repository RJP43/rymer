var persNote = 0;

$(window).ready(function(){
});

$(window).load(function(){		
	//$('a[class=person-link]').click(loadpersnote);
	
	$("#content").on('click', 'a[class=person-link]', loadpersnote);
});

$(document).ready(function() {
	$('.fancybox').fancybox();
});

function loadpersnote (e) {
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
			
			var insideSecondaryNote = $(this).closest('.pers-note-secondary').length;
			var insideNote = $(this).closest('.pers-note').length;
			
			if(insideSecondaryNote) {
				var $plinkAncestor = $(this).closest('.pers-note-secondary');
				$plinkAncestor.append('<span class="pers-note-secondary" id="pers-'+persNote+'"></span>');
			} else if(insideNote) {
				var $plinkAncestor = $(this).closest('.pers-note');
				$plinkAncestor.append('<span class="pers-note-secondary" id="pers-'+persNote+'"></span>');
			} else {
				$plink.after('<span class="pers-note" id="pers-'+persNote+'"></span>');
			}
			
			$( "#pers-"+persNote ).load ($plink.attr('href'));
			
			$( "#pers-"+persNote+" a[class=person-link]" ).click(loadpersnote);
			
			persNote = persNote + 1;
			return false;
		}
}

