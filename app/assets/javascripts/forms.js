$(function () {

  $('.side-module-share form, .inline-container form').on('click', function () {
    $(this).addClass('active');
  });

  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
  });

  var micropost = $('#micropost_content');

  function matchUser(string) {
    var Query = string.match(/\@\w+$/);

    return Query ? Query[0].substring(1) : false;
  }

  function getUsers(string, process) {
    var url = micropost.data('autocomplete-url')
    , match = matchUser(string);

    if(match) {
      return $.getJSON(url, {query: match}, function(data) {
        return process(data);
      });
    }
  }

  micropost.mention({
    queryBy: ['name', 'username']
  , users: getUsers
  });

});
