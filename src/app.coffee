
###
 # Module dependencies.
###
console.log("fire app.js")
express = require('express');
routes = require('./routes');
http = require('http');
path = require('path');
mongoose = require('mongoose')

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


# Connect Mongo DB
mongoURI = process.env.MONGOHQ_URL or 'mongodb://localhost/personalsite'
mongoose.connect(mongoURI)

# Set up Schema
Recipe = mongoose.model('Recipe', {
	name: String
	ingredient: String
	})

app.get('/', routes.index);
app.post '/submitdata', (req,res) ->
	submitedInfo = req.body
	recipe = new Recipe(submitedInfo)
	lantern.save (err,data) ->
		return
	return


http.createServer(app).listen(app.get('port'), () ->
	console.log('Express server listening on port ' + app.get('port'));
	return
);
