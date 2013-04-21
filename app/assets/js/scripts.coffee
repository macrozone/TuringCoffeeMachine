#= require draggableWindow.jquery.coffee
#= require Turing.coffee
#= require Engine.coffee
#= require Tape.coffee
#= require DragableWindow
#= require ColorMappingWindow
#= require Controller
#= require ConsoleDrawer.coffee
#= require CanvasDrawer.coffee
#= require CanvasDrawer2.coffee
#= require FunctionRepo.coffee
$ ->


	sample1 = 
		tapesContent: [
			"000000000000000000000000000000000000000000000000111111111111111111111111111111111111111111111111"
		]
		endState: 6
		functions: [
			("0": [1, " ", "R"], "1": [5, " ", "R"])
			("0": [1, "0", "R"], "1": [2, "1", "R"])
			("0": [3, "1", "L"], "1": [2, "1", "R"], " ": [4, " ", "L"])
			("0": [3, "0", "L"], "1": [3, "1", "L"], " ": [0, " ", "R"])
			("0": [4, "0", "L"], "1": [4, " ", "L"], " ": [6, "0", "R"])
			("0": [5, " ", "R"], "1": [5, " ", "R"], " ": [6, " ", "R"])


		]

	# 0^n1^n
	sample2 = 
		tapesContent: [
			"000000000000000000000000000000000000000000000000111111111111111111111111111111111111111111111111"
		]
		endState: 4
		functions: [
			("0": [1, "X", "R"], "Y": [3, "Y", "R"])
			("0": [1, "0", "R"], "Y": [1, "Y", "R"], "1": [2, "Y", "L"])
			("0": [2, "0", "L"], "Y": [2, "Y", "L"], "X": [0, "X", "R"])
			("Y": [3, "Y", "R"], " ": [4, " ", "R"])
			]

	sample3 = 
		tapesContent: [
			"000000000000000000000000000000000000000000000000111111111111111111111111111111111111111111111111"
			"000000000000000000000000000000000000000000000000111111111111111111111111111111111111111111111111"
			"000000000000000000000000000000000000000000000000111111111111111111111111111111111111111111111111"
		]
		endState: 4
		functions: [
			("000": [1, "XXX", "RRR"], "YYY": [3, "YYY", "RRR"])
			("000": [1, "000", "RRR"], "YYY": [1, "YYY", "RRR"], "111": [2, "YYY", "LLL"])
			("000": [2, "000", "LLL"], "YYY": [2, "YYY", "LLL"], "XXX": [0, "XXX", "RRR"])
			("YYY": [3, "YYY", "RRR"], "   ": [4, "   ", "RRR"])
		]

	sample3infitine = 
		tapesContent: [
			"000000000000000000000000000000000000000000000000111111111111111111111111111111111111111111111111"
			"000000000000000000000000000000000000000000000000111111111111111111111111111111111111111111111111"
			"000000000000000000000000000000000000000000000000111111111111111111111111111111111111111111111111"
		]
		endState: 6
		functions: [
			("000": [1, "XXX", "RRR"], "YYY": [3, "YYY", "RRR"])
			("000": [1, "000", "RRR"], "YYY": [1, "YYY", "RRR"], "111": [2, "YYY", "LLL"])
			("000": [2, "000", "LLL"], "YYY": [2, "YYY", "LLL"], "XXX": [0, "XXX", "RRR"])
			("YYY": [3, "YYY", "RRR"], "   ": [4, "   ", "RRR"])
			("   ": [4, "XXX", "RRR"])
		]

	addition = 
		tapesContent: [
			" 00000 000"
		]
		endState: 5
		functions: [
			(" ": [0, " ", "R"], "0": [1, "0", "R"])
			(" ": [2, "0", "R"], "0": [1, "0", "R"])
			(" ": [3, " ", "L"], "0": [2, "0", "R"])
			(" ": [3, " ", "L"], "0": [4, " ", "L"])
			(" ": [5, " ", "R"], "0": [4, "0", "L"])
		]


	window.turing = new Turing sample3


	
	window.engine = new Engine turing, {speed: 10}
	#engine.addDrawer new ConsoleDrawer
	canvas = document.getElementById("canvas")
	colorSettings =
		colorMappings:
			"0": "#FE906E"
			"1": "#FEDC6E"
			"X": "#6EFEDC"
			"Y": "#6E88FE"

	settings1 = 
		title: "Tape 1"
		scaleX: 10
		scaleY: 10
		colorSettings: colorSettings
		windowPositionX: 280
		historyScale: 1
		historySize: -1
		pixelDrawMode: "char"
	settings2 = 

		title: "Tape 2"
		
		colorSettings: colorSettings
		pixelPadding: 1
		windowPositionX: 800
		historyScale: 3
	settings3 = 

		title: "Tape 3"
		
		colorSettings: colorSettings
		pixelPadding: 1
		windowPositionX: 1100
		historyScale: 100

	

	engine.addDrawer (canvasDrawer =  new CanvasDrawer2 settings1), 0
	engine.addDrawer (canvasDrawer =  new CanvasDrawer2 settings2), 1
	engine.addDrawer (canvasDrawer =  new CanvasDrawer2 settings3), 2

	controller = new Controller engine, title: "Controller"

	engine.draw()

	new ColorMappingWindow colorSettings.colorMappings, {title: "Colors", windowPositionY: 150}
	

