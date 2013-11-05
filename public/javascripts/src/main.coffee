console.log("fire main.js")

$ -> 

	console.log("fire jQ")
	MultiAjaxAutoComplete = (element, url) ->
		$(element).select2({
			placeholder: "Search for a recipe",
			minimumInputLength: 1,
			multiple: true,
			ajax: {
				url: url,
				dataType: 'jsonp',
				data: (term, page) ->

					return {
						'_app_id': '48b32423' #app id
						'&_app_key':'f801fe2eacf40c98299940e2824de106' #my own apikey
						q: term,
						'maxResult': 10,
						
					};
				
				results: (data, page) ->
					return {
						results: data.matches
					};
				
			},
			formatResult: formatResult,
			formatSelection: formatSelection,
			initSelection: (element, callback) ->
				data = [];
				$(element.val().split(",")).each (i) ->
					item = this.split(':');
					data.push({
						totalMatchCount: item[0],
						matches: item[1]
					});
					return
				
				#$(element).val('');
				callback(data);
				return
			
		});
		return
	

	formatResult = (movie) ->
		return '<div>' + movie.matches + '</div>';


	formatSelection = (data) ->
		return data.matches;



	MultiAjaxAutoComplete('#e1', 'http://api.rottentomatoes.com/api/public/v1.0/movies.json');

	$("#e2").select2({
		placeholder: "Select a State",
		allowClear: true
		# multiple:  true
	});

	$(".chzn-select").chosen()

	$('#save').click () ->
		alert($('#e1').val());



	$('#e9').select2();
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
