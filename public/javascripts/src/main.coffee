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
	return
