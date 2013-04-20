root = exports ? this

root.ConsoleDrawer = class

	draw: (tape, tapeIndex) ->
	
		cursor = ""
		if tape.position > 0
			for i in [1..tape.position] 	
				cursor += " "
		cursor += "v"
		console.log cursor
		console.log tape.print()