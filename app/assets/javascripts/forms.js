$(function () {

    $('.side-module-share form, .inline-container form').on('click', function () {
      $(this).addClass('active');
    });
    $('.wysihtml5').each(function (elem) {
      $(elem).wysihtml5();
    });

    /* Thanks JBekker
      https://tinyurl.com/l8s2yv5
    */

    var micropost = $('#micropost_content');

    function matchUser(string) {
      var Query = string.match(/\@\w+$/);

      return Query ? Query[0].substring(1) : false;
    }

    function getUsers(string, process) {
      var url = micropost.data('autocomplete-url')
        , match = matchUser(string);

      if (match) {
        return $.getJSON(url, {query: match}, function(data) {
          var items = [];

          $.each(data, function() {
            items.push({
              name: this.realname
            , username: this.name
            });
          });

          return process(items);
        });
      }
    }

    micropost.mention({
      queryBy: ['name', 'username']
    , users: getUsers
    });

});
