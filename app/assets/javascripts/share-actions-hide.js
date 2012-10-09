$(document).ready(function(){
$(function(){
	$('.well').toggleClass('hover');
		$('.well-inner a').on('click', function(){
  		$('.well').toggleClass('hover');
    	});
	});
});
