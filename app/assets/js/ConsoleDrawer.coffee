root = exports ? this

root.ConsoleDrawer = class

	draw: (turing) ->
		console.log turing.printAll()