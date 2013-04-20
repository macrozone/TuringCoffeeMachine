#= require draggableWindow.jquery.coffee
#= require Turing.coffee
#= require Engine.coffee
#= require Tape.coffee

#= require ConsoleDrawer.coffee
#= require CanvasDrawer.coffee
#= require FunctionRepo.coffee
$ ->
	tapes = []
	tapes.push new Tape "0000000000000000000000000000000000011111111111111111111111111111111111"
	tapes.push new Tape "0000000000000000000000000000000000011111111111111111111111111111111111"
	tapes.push new Tape "0000000000000000000000000000000000011111111111111111111111111111111111"
	#Tapes.push new Tape "0000000 0000000000000000000000000000000"
	
	#Tapes.push new Tape "0011"
		
	console.log FunctionRepo.addition


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

	sample3 = [
		("000": [1, "XXX", "RRR"], "YYY": [3, "YYY", "RRR"])
		("000": [1, "000", "RRR"], "YYY": [1, "YYY", "RRR"], "111": [2, "YYY", "LLL"])
		("000": [2, "000", "LLL"], "YYY": [2, "YYY", "LLL"], "XXX": [0, "XXX", "RRR"])
		("YYY": [3, "YYY", "RRR"], "   ": [4, "   ", "RRR"])
	]

	addition = [
		(" ": [0, " ", "R"], "0": [1, "0", "R"])
		(" ": [2, "0", "R"], "0": [1, "0", "R"])
		(" ": [3, " ", "L"], "0": [2, "0", "R"])
		(" ": [3, " ", "L"], "0": [4, " ", "L"])
		(" ": [5, " ", "R"], "0": [4, "0", "L"])
	]


	window.turing = new Turing tapes, sample3, 4


	
	window.engine = new Engine turing, 0
	#engine.addDrawer new ConsoleDrawer
	canvas = document.getElementById("canvas")
	colorSettings = 
		backgroundColor: "black"
		cursorColor: "white"
		fadeTrashhold: 0.75
		colorMappings:
			"0": "#FE906E"
			"1": "#FEDC6E"
			"X": "#6EFEDC"
			"Y": "#6E88FE"

	settings1 = 
		title: "Tape 1"
		scaleX: 7
		scaleY: 7
		colorSettings: colorSettings
		pixelPadding: 1
		windowXOffset: 0
		historySteps: 1
	settings2 = 

		title: "Tape 2"
		scaleX: 5
		scaleY: 5
		colorSettings: colorSettings
		pixelPadding: 1
		windowXOffset: 700
		historySteps: 50
	settings3 = 

		title: "Tape 3"
		scaleX: 5
		scaleY: 5
		colorSettings: colorSettings
		pixelPadding: 1
		windowXOffset: 1000
		historySteps: 100

	
	engine.addDrawer (canvasDrawer =  new CanvasDrawer settings1), 0
	engine.addDrawer (canvasDrawer =  new CanvasDrawer settings2), 1
	engine.addDrawer (canvasDrawer =  new CanvasDrawer settings3), 2
	engine.run()

	

