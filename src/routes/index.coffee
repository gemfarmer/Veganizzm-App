console.log("fire index.js")
request = require 'request'
exports.index = (req, res) ->
	credentials = {
		yummlyAppId : '_app_id=48b32423'
		yummlyAppKey : "&_app_key=f801fe2eacf40c98299940e2824de106"
	}


	yummlyUrl = 'http://api.yummly.com/v1/api/metadata/course?'+credentials.yummlyAppId+credentials.yummlyAppKey

	request(yummlyUrl, (error, response, body) ->
		console.log("allergilicioius",body)
		parsedBody = JSON.parse(body)
		# console.log(response)
		return
	)
	dietData =  [{"id":"386","shortDescription":"Vegan","longDescription":"Vegan","searchValue":"386^Vegan","type":"diet"},{"id":"388","shortDescription":"Lacto vegetarian","longDescription":"Lacto vegetarian","searchValue":"388^Lacto vegetarian","type":"diet"},{"id":"389","shortDescription":"Ovo vegetarian","longDescription":"Ovo vegetarian","searchValue":"389^Ovo vegetarian","type":"diet"},{"id":"390","shortDescription":"Pescetarian","longDescription":"Pescetarian","searchValue":"390^Pescetarian","type":"diet"},{"id":"387","shortDescription":"Lacto-ovo vegetarian","longDescription":"Vegetarian","searchValue":"387^Lacto-ovo vegetarian","type":"diet"}]
	allergyData = [{"id":"392","shortDescription":"Wheat-Free","longDescription":"Wheat-Free","searchValue":"392^Wheat-Free","type":"allergy"},{"id":"393","shortDescription":"Gluten-Free","longDescription":"Gluten-Free","searchValue":"393^Gluten-Free","type":"allergy"},{"id":"394","shortDescription":"Peanut-Free","longDescription":"Peanut-Free","searchValue":"394^Peanut-Free","type":"allergy"},{"id":"395","shortDescription":"Tree Nut-Free","longDescription":"Tree Nut-Free","searchValue":"395^Tree Nut-Free","type":"allergy"},{"id":"396","shortDescription":"Dairy-Free","longDescription":"Dairy-Free","searchValue":"396^Dairy-Free","type":"allergy"},{"id":"397","shortDescription":"Egg-Free","longDescription":"Egg-Free","searchValue":"397^Egg-Free","type":"allergy"},{"id":"398","shortDescription":"Seafood-Free","longDescription":"Seafood-Free","searchValue":"398^Seafood-Free","type":"allergy"},{"id":"399","shortDescription":"Sesame-Free","longDescription":"Sesame-Free","searchValue":"399^Sesame-Free","type":"allergy"},{"id":"400","shortDescription":"Soy-Free","longDescription":"Soy-Free","searchValue":"400^Soy-Free","type":"allergy"},{"id":"401","shortDescription":"Sulfite-Free","longDescription":"Sulfite-Free","searchValue":"401^Sulfite-Free","type":"allergy"}]
	cuisineData = [{"id":"cuisine-american","type":"cuisine","description":"American","searchValue":"cuisine^cuisine-american"},{"id":"cuisine-italian","type":"cuisine","description":"Italian","searchValue":"cuisine^cuisine-italian"},{"id":"cuisine-asian","type":"cuisine","description":"Asian","searchValue":"cuisine^cuisine-asian"},{"id":"cuisine-mexican","type":"cuisine","description":"Mexican","searchValue":"cuisine^cuisine-mexican"},{"id":"cuisine-southern","type":"cuisine","description":"Southern & Soul Food","searchValue":"cuisine^cuisine-southern"},{"id":"cuisine-french","type":"cuisine","description":"French","searchValue":"cuisine^cuisine-french"},{"id":"cuisine-southwestern","type":"cuisine","description":"Southwestern","searchValue":"cuisine^cuisine-southwestern"},{"id":"cuisine-barbecue-bbq","type":"cuisine","description":"Barbecue","searchValue":"cuisine^cuisine-barbecue-bbq"},{"id":"cuisine-indian","type":"cuisine","description":"Indian","searchValue":"cuisine^cuisine-indian"},{"id":"cuisine-chinese","type":"cuisine","description":"Chinese","searchValue":"cuisine^cuisine-chinese"},{"id":"cuisine-cajun","type":"cuisine","description":"Cajun & Creole","searchValue":"cuisine^cuisine-cajun"},{"id":"cuisine-mediterranean","type":"cuisine","description":"Mediterranean","searchValue":"cuisine^cuisine-mediterranean"},{"id":"cuisine-greek","type":"cuisine","description":"Greek","searchValue":"cuisine^cuisine-greek"},{"id":"cuisine-english","type":"cuisine","description":"English","searchValue":"cuisine^cuisine-english"},{"id":"cuisine-spanish","type":"cuisine","description":"Spanish","searchValue":"cuisine^cuisine-spanish"},{"id":"cuisine-thai","type":"cuisine","description":"Thai","searchValue":"cuisine^cuisine-thai"},{"id":"cuisine-german","type":"cuisine","description":"German","searchValue":"cuisine^cuisine-german"},{"id":"cuisine-moroccan","type":"cuisine","description":"Moroccan","searchValue":"cuisine^cuisine-moroccan"},{"id":"cuisine-irish","type":"cuisine","description":"Irish","searchValue":"cuisine^cuisine-irish"},{"id":"cuisine-japanese","type":"cuisine","description":"Japanese","searchValue":"cuisine^cuisine-japanese"},{"id":"cuisine-cuban","type":"cuisine","description":"Cuban","searchValue":"cuisine^cuisine-cuban"},{"id":"cuisine-hawaiian","type":"cuisine","description":"Hawaiian","searchValue":"cuisine^cuisine-hawaiian"},{"id":"cuisine-swedish","type":"cuisine","description":"Swedish","searchValue":"cuisine^cuisine-swedish"},{"id":"cuisine-portuguese","type":"cuisine","description":"Portuguese","searchValue":"cuisine^cuisine-portuguese"},{"id":"cuisine-hungarian","type":"cuisine","description":"Hungarian","searchValue":"cuisine^cuisine-hungarian"}]
	courseData = [{"id":"course-Main Dishes","type":"course","description":"Main Dishes","searchValue":"course^course-Main Dishes"},{"id":"course-Desserts","type":"course","description":"Desserts","searchValue":"course^course-Desserts"},{"id":"course-Side Dishes","type":"course","description":"Side Dishes","searchValue":"course^course-Side Dishes"},{"id":"course-Lunch and Snacks","type":"course","description":"Lunch and Snacks","searchValue":"course^course-Lunch and Snacks"},{"id":"course-Appetizers","type":"course","description":"Appetizers","searchValue":"course^course-Appetizers"},{"id":"course-Salads","type":"course","description":"Salads","searchValue":"course^course-Salads"},{"id":"course-Breakfast and Brunch","type":"course","description":"Breakfast and Brunch","searchValue":"course^course-Breakfast and Brunch"},{"id":"course-Breads","type":"course","description":"Breads","searchValue":"course^course-Breads"},{"id":"course-Soups","type":"course","description":"Soups","searchValue":"course^course-Soups"},{"id":"course-Beverages","type":"course","description":"Beverages","searchValue":"course^course-Beverages"},{"id":"course-Condiments and Sauces","type":"course","description":"Condiments and Sauces","searchValue":"course^course-Condiments and Sauces"},{"id":"course-Cocktails","type":"course","description":"Cocktails","searchValue":"course^course-Cocktails"}]
	res.render('index', 
			{ 
				title: 'Veganizzm App', 
				allowedCuisine: cuisineData,
				allowedCourse: courseData,
				allowedAllergy: allergyData,
				allowedDiet: dietData
			},

		)
		return
	return
