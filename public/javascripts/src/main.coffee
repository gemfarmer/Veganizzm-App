console.log("fire main.js")

$ -> 
	console.log("fire jQ")
	
	$('.querySearch').on 'keyup', (e) ->
		val = $(this).val()
		$.get '/searchRecipes', val, (data) ->


	$(".chzn-select").chosen()

	$('#recipe-form').on 'submit', (e) ->
		e.preventDefault()
		# console.log($(this))

		info = $(this).serialize()

		console.log("info",info)

		$.post '/submitrecipe', info, (data) ->
			console.log(data)
			for i of data.matches
				recipe = data.matches[i]
				console.log(recipe)
			