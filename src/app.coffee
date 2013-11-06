
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
async = require 'async'
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

credentials = {
		yummlyAppId : '_app_id=48b32423'
		yummlyAppKey : "&_app_key=f801fe2eacf40c98299940e2824de106"
}


# Connect Mongo DB
mongoURI = process.env.MONGOHQ_URL or 'mongodb://localhost/veganizzmapp'
mongoose.connect(mongoURI)

# Set up Schema
RecipeSearch = mongoose.model('RecipeSearch', {
	q: String
	allowedCuisine: String
	allowedCourse: String
	allowedAllergy: String
	allowedDiet: String
	})


app.get('/', routes.index);
# app.post('submitrecipe', routes.yummly)
app.post '/submitrecipe', (req,res) ->


	submittedInfo = req.body
	console.log("submittedInfo", submittedInfo)
	recipeSearch = new RecipeSearch(submittedInfo)
	recipeSearch.save (err,data) ->
		console.log("sent to database:",data)
		return
	console.log("HEYYEYEYEYYEYE",submittedInfo)
	#Create Search Criteria strings

	queryArray = {
		recipeQuery : "&q="+submittedInfo.q
		checkCourse :"&allowedCourse[]="+submittedInfo.allowedCourse
		checkAllergies: "&allowedAllergy[]="+submittedInfo.allowedAllergy
		checkDiet : "&allowedDiet[]="+submittedInfo.allowedDiet
		checkCuisine : "&allowedCuisine[]="+submittedInfo.allowedCuisine
	}
	# console.log("checkDiet",checkDiet)

	# add logic to determine query suffix
	urlExtras = []

	if queryArray.recipeQuery != false
		urlExtras.push(queryArray.recipeQuery)
	if queryArray.checkCourse != false
		urlExtras.push(queryArray.checkCourse)
	if queryArray.checkAllergies != false
		urlExtras.push(queryArray.checkAllergies)
	if queryArray.checkDiet != false
		urlExtras.push(queryArray.checkDiet)
	if queryArray.checkCuisine != false
		urlExtras.push(queryArray.checkCuisine)

	
	console.log('urlExtras',urlExtras)

	requestYummlyUrl = "http://api.yummly.com/v1/api/recipes?"+credentials.yummlyAppId+credentials.yummlyAppKey+urlExtras
	console.log(requestYummlyUrl)
	#Pull Yummly API
	queryYummlyrecipes = (callback) ->
		request requestYummlyUrl, (error, response, body) ->
		# console.log(body);

		yummlyObj = JSON.parse(body)
		# console.log("totalMatchCount",totalMatchCount)
		callback(null, yummlyObj)

	# set object to send
	toSend = {}

	#define async task
	tasks = [
		(cb) ->
			queryYummlyrecipes (err, data) ->
				toSend.totalMatchCount = data['totalMatchCount']
				toSend.criteria = data['criteria']
				toSend.matches = data['matches']
				cb()
	]
	# perform a sync task RES.SEND
	async.series tasks, () ->
		res.send toSend

http.createServer(app).listen(app.get('port'), () ->
	console.log('Express server listening on port ' + app.get('port'));
	return
);
