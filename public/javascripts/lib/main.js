// Generated by CoffeeScript 1.6.3
(function() {
  console.log("fire main.js");

  $(function() {
    console.log("fire jQ");
    $('.querySearch').on('keyup', function(e) {
      var val;
      val = $(this).val();
      return $.get('/searchRecipes', val, function(data) {});
    });
    $(".chzn-select").chosen();
    return $('#recipe-form').on('submit', function(e) {
      var info;
      e.preventDefault();
      info = $(this).serialize();
      console.log("info", info);
      return $.post('/submitrecipe', info, function(data) {
        var i, recipe, _results;
        console.log(data);
        _results = [];
        for (i in data.matches) {
          recipe = data.matches[i];
          _results.push(console.log(recipe));
        }
        return _results;
      });
    });
  });

}).call(this);
