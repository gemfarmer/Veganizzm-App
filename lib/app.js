// Generated by CoffeeScript 1.6.3

/*
  * Module dependencies.
 */

(function() {
  var RecipeSearch, app, async, credentials, express, http, mongoURI, mongoose, path, request, routes;

  console.log("fire app.js");

  express = require('express');

  routes = require('./routes');

  http = require('http');

  path = require('path');

  mongoose = require('mongoose');

  request = require('request');

  async = require('async');

  app = express();

  app.set('port', process.env.PORT || 3000);

  app.set('views', __dirname + '/../views');

  app.set('view engine', 'jade');

  app.use(express.favicon());

  app.use(express.logger('dev'));

  app.use(express.bodyParser());

  app.use(express.methodOverride());

  app.use(app.router);

  app.use(express["static"](path.join(__dirname, '/../public')));

  if ('development' === app.get('env')) {
    app.use(express.errorHandler());
  }

  credentials = {
    yummlyAppId: '_app_id=48b32423',
    yummlyAppKey: "&_app_key=f801fe2eacf40c98299940e2824de106"
  };

  mongoURI = process.env.MONGOHQ_URL || 'mongodb://localhost/veganizzmapp';

  mongoose.connect(mongoURI);

  RecipeSearch = mongoose.model('RecipeSearch', {
    q: String,
    allowedCuisine: String,
    allowedCourse: String,
    allowedAllergy: String,
    allowedDiet: String
  });

  app.get('/', routes.index);

  app.post('/submitrecipe', function(req, res) {
    var i, j, joinedURL, prepend, queryArray, queryObj, queryPrefix, recipeSearch, requestYummlyUrl, submittedInfo, urlExtras, _i, _len, _ref;
    submittedInfo = req.body;
    console.log("submittedInfo", submittedInfo);
    recipeSearch = new RecipeSearch(submittedInfo);
    recipeSearch.save(function(err, data) {
      console.log("sent to database:", data);
    });
    queryPrefix = {
      allowedCourse: "&allowedCourse[]=",
      allowedAllergy: "&allowedAllergy[]=",
      allowedDiet: "&allowedDiet[]=",
      allowedCuisine: "&allowedCuisine[]="
    };
    queryObj = {};
    for (i in submittedInfo) {
      if (typeof submittedInfo[i] === "object") {
        queryArray = [];
        prepend = function() {
          queryArray.push(queryPrefix[i] + j);
          return queryObj[i] = queryArray.join("");
        };
        _ref = submittedInfo[i];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          j = _ref[_i];
          prepend();
        }
      } else {
        queryObj[i] = queryPrefix[i] + submittedInfo[i];
      }
    }
    urlExtras = [];
    if (queryObj.allowedCourse !== false) {
      urlExtras.push(queryObj.allowedCourse);
    }
    if (queryObj.allowedAllergy !== false) {
      urlExtras.push(queryObj.allowedAllergy);
    }
    if (queryObj.allowedDiet !== false) {
      urlExtras.push(queryObj.allowedDiet);
    }
    if (queryObj.allowedCuisine !== false) {
      urlExtras.push(queryObj.allowedCuisine);
    }
    console.log('urlExtras', urlExtras);
    joinedURL = urlExtras.join("");
    requestYummlyUrl = "http://api.yummly.com/v1/api/recipes?" + credentials.yummlyAppId + credentials.yummlyAppKey + joinedURL;
    console.log(requestYummlyUrl);
    return request(requestYummlyUrl, function(error, response, body) {
      var recipeObj, yummlyObj;
      recipeObj = {};
      yummlyObj = JSON.parse(body);
      recipeObj.totalMatchCount = yummlyObj['totalMatchCount'];
      recipeObj.criteria = yummlyObj['criteria'];
      recipeObj.matches = yummlyObj['matches'];
      recipeObj.attribution = yummlyObj['attribution'];
      res.send(recipeObj);
    });
  });

  http.createServer(app).listen(app.get('port'), function() {
    console.log('Express server listening on port ' + app.get('port'));
  });

}).call(this);
