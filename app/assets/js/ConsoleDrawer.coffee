root = exports ? this

root.ConsoleDrawer = class

	draw: (band, bandIndex) ->
	
		cursor = ""
		if band.position > 0
			for i in [1..band.position] 	
				cursor += " "
		cursor += "v"
		console.log cursor
		console.log band.print()