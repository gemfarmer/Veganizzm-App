
###
 # Module dependencies.
###
console.log("fire app.js")
express = require('express');
routes = require('./routes');
http = require('http');
path = require('path');
mongoose = require('mongoose')
request = require('request')

app = express();

# all environments
app.set('port', process.env.PORT or 3000);
app.set('views', __dirname + '/../views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, '/../public')));

# development only
if ('development' == app.get('env'))
	app.use(express.errorHandler());

# Yummly Authentication
yummlyAppId = '48b32423'
yummlyAppKey = "f801fe2eacf40c98299940e2824de106"

#Pull Yummly API
app.get '/recipes', (req, res) ->
	request("http://api.yummly.com/v1/api/recipes?_app_id="+yummlyAppId+"&_app_key="+yummlyAppKey+"&q=onion+chicken", (error, response, body) ->
		# console.log(body);
		recipeObj = {
			totalMatchCount: 0
		}
		yummlyObj = JSON.parse(body)

		recipeObj.totalMatchCount = yummlyObj['totalMatchCount']
		recipeObj.matches = yummlyObj['matches']
		# console.log("totalMatchCount",totalMatchCount)
		res.send(recipeObj)
		res.send(yummlyObj)
		return
	)
	return




# Connect Mongo DB
mongoURI = process.env.MONGOHQ_URL or 'mongodb://localhost/veganizzmapp'
mongoose.connect(mongoURI)

# Set up Schema
Recipe = mongoose.model('Recipe', {
	name: String
	ingredient: String
	})


app.get('/', routes.index);
app.post '/submitdata', (req,res) ->
	submitedInfo = req.body
	console.log("submitedInfo", submitedInfo)
	recipe = new Recipe(submitedInfo)
	recipe.save (err,data) ->
		console.log("sent to database:",data)
		return
	return


http.createServer(app).listen(app.get('port'), () ->
	console.log('Express server listening on port ' + app.get('port'));
	return
);
