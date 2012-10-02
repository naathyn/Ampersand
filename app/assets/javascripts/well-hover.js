$(document).ready(function(){
	$("div.well").on({
  	hover: function(){
    	$(this).toggleClass("active");
  	},
  	mouseenter: function(){
    	$(this).addClass("inside");
  	},
  	mouseleave: function(){
    	$(this).removeClass("inside");
  	}
	});
});
