var persNote = 0;
var noteNum = 0;

$(window).ready(function(){
});

$(window).load(function(){		
	//$('a[class=person-link]').click(loadpersnote);
	
	$("#content").on('click', 'a[class=person-link]', loadpersnote);
	$("#content").on('click', 'a[class=note-link]', loadnote);
	$("#content").on('click', 'a[class=spoiler-toggle]', togglespoiler);
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
			
			persNote = persNote + 1;
			return false;
		}
}

function loadnote (e) {
		e.preventDefault();
		var $nlink = $(this);

		if(typeof $nlink.attr('id') !== 'undefined') {
			var noteid = $nlink.attr('id').substr(4);
			$note = $( "#"+noteid );
			if($note.attr('style') == 'undefined' || $note.attr('style') == 'display:none;') {
				$note.attr('style', 'display:block;');
			} else {
				$note.attr('style', 'display:none;');
			}
		} else {
			$nlink.attr('id', 'ref-note-'+noteNum);
			
			$nlink.after('<span class="note" id="note-'+noteNum+'"></span>');
			
			$( "#note-"+noteNum ).load ($nlink.attr('href'));
			
			noteNum = noteNum + 1;
			return false;
		}
}

function togglespoiler (e) {
	if($('.spoiler').attr('style') == 'display:none;') {
		$('.spoiler').attr('style', 'display:block;');
		$(this).text('Hide Spoilers');
	} else {
		$('.spoiler').attr('style', 'display:none;');
		$(this).text('Show Spoilers');
	}
}


