
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
	queryPrefix = {
		q : "&q="
		allowedCourse : "&allowedCourse[]="
		allowedAllergy : "&allowedAllergy[]="
		allowedDiet : "&allowedDiet[]="
		allowedCuisine : "&allowedCuisine[]="
	}
	queryObj = {}
	for i of submittedInfo
		if typeof(submittedInfo[i]) == "object"
			# console.log("INSTANCE")
			queryArray = []
			prepend = () ->
				
				queryArray.push(queryPrefix[i] + j)
				queryObj[i] = queryArray.join("")
				# console.log("QUERY ARRAY",queryArray)
			prepend() for j in submittedInfo[i]
		else 
			queryObj[i] = queryPrefix[i] + submittedInfo[i]



	#Create Search Criteria strings

	# queryArray = {
	# 	recipeQuery : "&q="+submittedInfo.q
	# 	checkCourse :"&allowedCourse[]="+submittedInfo.allowedCourse
	# 	checkAllergies: "&allowedAllergy[]="+submittedInfo.allowedAllergy
	# 	checkDiet : "&allowedDiet[]="+submittedInfo.allowedDiet
	# 	checkCuisine : "&allowedCuisine[]="+submittedInfo.allowedCuisine
	# }
	# console.log("checkDiet",checkDiet)

	# add logic to determine query suffix
	urlExtras = []

	if queryObj.q != false
		urlExtras.push(queryObj.q)
	if queryObj.allowedCourse != false
		urlExtras.push(queryObj.allowedCourse)
	if queryObj.allowedAllergy != false
		urlExtras.push(queryObj.allowedAllergy)
	if queryObj.allowedDiet != false
		urlExtras.push(queryObj.allowedDiet)
	if queryObj.allowedCuisine != false
		urlExtras.push(queryObj.allowedCuisine)

	
	console.log('urlExtras',urlExtras)
	joinedURL = urlExtras.join("")

	requestYummlyUrl = "http://api.yummly.com/v1/api/recipes?"+credentials.yummlyAppId+credentials.yummlyAppKey+joinedURL
	console.log(requestYummlyUrl)
	#Pull Yummly API
	request requestYummlyUrl, (error, response, body) ->

		# console.log(body);
		recipeObj = {}
		yummlyObj = JSON.parse(body)

		recipeObj.totalMatchCount = yummlyObj['totalMatchCount']
		recipeObj.criteria = yummlyObj['criteria']
		recipeObj.matches = yummlyObj['matches']
		
		# console.log("totalMatchCount",totalMatchCount)
		res.send(recipeObj)
		# res.send(yummlyObj)
		return


http.createServer(app).listen(app.get('port'), () ->
	console.log('Express server listening on port ' + app.get('port'));
	return
);
