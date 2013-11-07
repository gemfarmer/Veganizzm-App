console.log("fire index.js")
request = require 'request'
async = require 'async'


exports.index = (req, res) ->
	searchMetaParam = {
		allergy: 'allergy'
		diet: 'diet'
		cuisine: 'cuisine'
		course: 'course'
	}
	serachParam = 
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

	getRecipeData = (callback) ->

		yummlyQUrl = "http://api.yummly.com/v1/api/recipes?"+credentials.yummlyAppId+credentials.yummlyAppKey
		console.log(yummlyQUrl)
		#Pull Yummly API
		request yummlyQUrl, (error, response, body) ->

			# console.log(body);
			recipeObj = {}
			yummlyObj = JSON.parse(body)
			console.log("YUM", yummlyObj)


			# recipeObj.totalMatchCount = yummlyObj['totalMatchCount']
			# recipeObj.criteria = yummlyObj['criteria']
			# recipeObj.matches = yummlyObj['matches']
			# recipeObj.attribution = yummlyObj['attribution']
			
			# console.log("totalMatchCount",totalMatchCount)
			# callback(null, recipeObj)
			callback(null, yummlyObj.matches)

			return


	toRender = {
		title: 'Veganizzm App'
	}

	tasks = [
		(cb) ->
			getMetaData searchMetaParam.cuisine, (err, data) ->
				toRender.allowedCuisine = data
				cb()
		,
		(cb) ->
			getMetaData searchMetaParam.course, (err, data) ->
				toRender.allowedCourse = data
				cb()
		,
		(cb) ->
			getMetaData searchMetaParam.allergy, (err, data) ->
				toRender.allowedAllergy = data
				cb()
		,
		(cb) ->
			getMetaData searchMetaParam.diet, (err, data) ->
				toRender.allowedDiet = data
				cb()
		,
		(cb) ->
			getRecipeData (err, data) ->
				toRender.q = data
				cb()
	]

	# use parallel instead of series because none of the tasks rely on one another
	# added query, changed to series
	async.series tasks, () ->
		res.render 'index', toRender

