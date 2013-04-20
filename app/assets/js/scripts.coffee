#= require Turing.coffee
#= require Engine.coffee
#= require Band.coffee

#= require ConsoleDrawer.coffee
$ ->
	bands = []
	bands.push new Band "0000000000000000000000000000000000011111111111111111111111111111111111"
	#bands.push new Band "0011"
		



	sample1 = [
		("0": [1, " ", "R"], "1": [5, " ", "R"])
		("0": [1, "0", "R"], "1": [2, "1", "R"])
		("0": [3, "1", "L"], "1": [2, "1", "R"], " ": [4, " ", "L"])
		("0": [3, "0", "L"], "1": [3, "1", "L"], " ": [0, " ", "R"])
		("0": [4, "0", "L"], "1": [4, " ", "L"], " ": [6, "0", "R"])
		("0": [5, " ", "R"], "1": [5, " ", "R"], " ": [6, " ", "R"])


	]

	# 0^n1^n
	sample2 = [
		("0": [1, "X", "R"], "Y": [3, "Y", "R"])
		("0": [1, "0", "R"], "Y": [1, "Y", "R"], "1": [2, "Y", "L"])
		("0": [2, "0", "L"], "Y": [2, "Y", "L"], "X": [0, "X", "R"])
		("Y": [3, "Y", "R"], " ": [4, " ", "R"])
	]

	window.turing = new Turing bands, sample2, 4


	
	window.engine = new Engine turing, 0
	engine.addDrawer new ConsoleDrawer
	engine.run()

	

