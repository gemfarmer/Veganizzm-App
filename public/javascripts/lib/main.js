// Generated by CoffeeScript 1.6.3
(function() {
  console.log("fire main.js");

  $(function() {
    $('form').on('click', function(e) {
      var info;
      e.preventDefault();
      console.log($(this));
      info = $(this).serialize();
      console.log("info", info);
      return $.post('/submitrecipe', info, function(data) {
        var i, recipe;
        console.log(data);
        for (i in data.matches) {
          recipe = data.matches[i];
          console.log(recipe);
          return;
        }
      });
    });
  });

}).call(this);
