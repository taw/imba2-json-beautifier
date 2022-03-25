import stringify from "json-stringify-pretty-compact"

tag app
	prop maxlen = 80
	prop indent = 2
	prop text = JSON.stringify({hello: "world"})
	prop error

	def prettify
		try
			let json = JSON.parse(text)
			let spaces = Array.from({length: parseInt(indent)+1}).join(" ")
			text = stringify(json, {maxLength: parseInt(maxlen), indent: spaces})
		catch e
			error = ""+e
		imba.commit()

	def clear_error
		error = null

	def upload(event)
		let file = event.target.files[0]
		return unless file
		let reader = new FileReader

		reader.onload = do |event|
			text = event.target.result
			error = nil
			imba.commit()
		reader.readAsText(file)

	<self>
		<header>
			"JSON Beautifier"
		<textarea bind=text rows=10 :input.clear_error>
		if error
			<div.error>
				error
		<div.controls>
			<input#file type="file" :change.upload>
			<label for="indent">
				"Indent"
			<input#indent bind=indent type="number" min=0>
			<label for="maxlen">
				"Max row length"
			<input#maxlen bind=maxlen type="number" min=0>
			<button :click.prettify>
				"Prettify"

	css
		display: flex
		flex-direction: column
		align-items: center
		ff: sans

		header
			font-size: 64px
			text-align: center

		textarea
			min-width: 50vw
			margin-bottom: 10px

		.controls
			display: grid
			grid-row-gap: 5px
			margin: auto

			label
				grid-column: 1
			input, button
				grid-column: 2

		.error
			background-color: #fcc
			min-width: 50vw
			padding: 5px
			border: 1px solid #800

imba.mount <app>
