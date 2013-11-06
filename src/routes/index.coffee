console.log("fire index.js")
request = require 'request'
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
	
	getMetaData = (param, credentials) ->

		yummlyUrl = 'http://api.yummly.com/v1/api/metadata/'+param+'?'+credentials.yummlyAppId+credentials.yummlyAppKey
		pushedData = []
		request(yummlyUrl, (error, response, body) ->
			# console.log body
			
			data = body.replace("set_metadata('"+param+"',", '').replace(');', '')
			# console.log(JSON.parse(data))
	
			pushedData.push(JSON.parse(data))

			
		)
		console.log("jsdafsdf")

		
		setTimeout( () ->
		# console.log("pushedData:",pushedData[0])

			pushedData[0]

		, 3000)


		# return console.log(timer)
		
		# setTimeout(console.log("ooollala", pushedData), 20000)
		
		# return pushedData
		# getMetaData searchParam.allergy, credentials, (err, data) ->


	
	whatever = getMetaData(searchParam.cuisine, credentials)
	console.log("whatever",whatever)

	# res.render 'index', { 
	# 	title: 'Veganizzm App', 
	# 	allowedCuisine: getMetaData searchParam.cuisine, credentials
	# 	allowedCourse: getMetaData searchParam.course, credentials
	# 	allowedAllergy: getMetaData searchParam.allergy, credentials
	# 	allowedDiet: getMetaData searchParam.diet, credentials
	# }
		
	return
