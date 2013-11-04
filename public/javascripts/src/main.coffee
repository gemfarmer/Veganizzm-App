console.log("fire main.js")



$ -> 
	$('form').on 'click', (e) ->
		e.preventDefault()
		console.log($(this))

		info = $(this).serialize()

		console.log("info",info)

		$.post '/submitdata', info, (data) ->
			return
		return
	$.get '/recipes', (data) ->
		console.log(data)
		return
	return
