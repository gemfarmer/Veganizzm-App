console.log("fire main.js")

$ -> 

	console.log("fire jQ")
	MultiAjaxAutoComplete = (element, url) ->
		$(element).select2({
			placeholder: "Search for a movie",
			minimumInputLength: 1,
			multiple: true,
			ajax: {
				url: url,
				dataType: 'jsonp',
				data: (term, page) ->

					return {
						q: term,
						page_limit: 10,
						apikey: "z4vbb4bjmgsb7dy33kvux3ea" #my own apikey
					};
				
				results: (data, page) ->
					return {
						results: data.movies
					};
				
			},
			formatResult: formatResult,
			formatSelection: formatSelection,
			initSelection: (element, callback) ->
				data = [];
				$(element.val().split(",")).each (i) ->
					item = this.split(':');
					data.push({
						id: item[0],
						title: item[1]
					});
					return
				
				#$(element).val('');
				callback(data);
				return
			
		});
		return
	

	formatResult = (movie) ->
		return '<div>' + movie.title + '</div>';


	formatSelection = (data) ->
		return data.title;



	MultiAjaxAutoComplete('#e1', 'http://api.rottentomatoes.com/api/public/v1.0/movies.json');

	$('#save').click () ->
		alert($('#e1').val());




	$('#e9').select2();
	$('form').on 'click', (e) ->
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
