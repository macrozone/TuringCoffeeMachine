root = exports ? this

root.ConsoleDrawer = class

	draw: (turing) ->
	
		cursor = ""
		if turing.bands[0].position > 0
			for i in [1..turing.bands[0].position] 	
				cursor += " "
		cursor += "v"
		console.log cursor
		console.log turing.printAll().join " , "