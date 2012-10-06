$(document).ready(function(){
	$("div.well li div#like_form").on({
  	click: function(){
    	$(this).toggleClass("shares_unliked");
  	}
	});
});
