console.log("fire index.js")
request = require 'request'
async = require 'async'


exports.index = (req, res) ->
	searchParam = {
		allergy: 'allergy'
		diet: 'diet'
		cuisine: 'cuisine'
		course: 'course'
	}
	credentials = {
		yummlyAppId : '_app_id=48b32423'
		yummlyAppKey : "&_app_key=f801fe2eacf40c98299940e2824de106"
	}
	
	getMetaData = (param, callback) ->

		yummlyUrl = 'http://api.yummly.com/v1/api/metadata/'+param+'?'+credentials.yummlyAppId+credentials.yummlyAppKey
		request(yummlyUrl, (error, response, body) ->	
				data = body.replace("set_metadata('"+param+"',", '').replace(');', '')
				
				callback(null, JSON.parse(data)) 
		)

	toRender = {
		title: 'Veganizzm App'
	}

	tasks = [
		(cb) ->
			getMetaData searchParam.cuisine, (err, data) ->
				toRender.allowedCuisine = data
				cb()
		,
		(cb) ->
			getMetaData searchParam.course, (err, data) ->
				toRender.allowedCourse = data
				cb()
		,
		(cb) ->
			getMetaData searchParam.allergy, (err, data) ->
				toRender.allowedAllergy = data
				cb()
		,
		(cb) ->
			getMetaData searchParam.diet, (err, data) ->
				toRender.allowedDiet = data
				cb()
	]

	# use parallel instead of series because none of the tasks rely on one another
	async.parallel tasks, () ->
		res.render 'index', toRender

