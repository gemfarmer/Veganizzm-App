console.log("fire main.js")

$ -> 

	console.log("fire jQ")
	
	$(".chzn-select").chosen()

	$('input').on 'click', (e) ->
		e.preventDefault()
		console.log($(this))

		info = $(this).serialize()

		console.log("info",info)

		$.post '/submitrecipe', info, (data) ->
			console.log(data)
			for i of data.matches
				recipe = data.matches[i]
				console.log(recipe)
				return
			return

	
	return
