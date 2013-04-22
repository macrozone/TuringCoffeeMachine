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

#= require Setup.coffee
#= require SingleTapeSetup.coffee

$ ->

	###
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
			"00000 000000000"
		]
		endState: 5
		functions: [
			(" ": [0, " ", "R"], "0": [1, "0", "R"])
			(" ": [2, "0", "R"], "0": [1, "0", "R"])
			(" ": [3, " ", "L"], "0": [2, "0", "R"])
			(" ": [3, " ", "L"], "0": [4, " ", "L"])
			(" ": [5, " ", "R"], "0": [4, "0", "L"])
		]


	colorSettings =
		colorMappings:
			"0": "#FE906E"
			"1": "#FEDC6E"
			"X": "#6EFEDC"
			"Y": "#6E88FE"
			fallback: "#fff"

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

		title: "Tape 1 - 10x"
		
		colorSettings: colorSettings
		windowPositionX: 800
		historyScale: 10
	settings3 = 

		title: "Tape 1 - 100x"
		colorSettings: colorSettings
		windowPositionX: 1100
		historyScale: 100

	

	turing = new Turing multiplication

	engine = new Engine turing
	

	engine.addDrawer (new CanvasDrawer2 settings1), 0
	engine.addDrawer (new CanvasDrawer2 settings2), 0
	engine.addDrawer (new CanvasDrawer2 settings3), 0
	engine.addDrawer (new CharCounterDrawer colorSettings: colorSettings,  windowPositionY: 280, title: "Char-Counter Tape 1"), 0

	new Controller engine, title: "Controller"

	new ColorMappingWindow colorSettings.colorMappings, {title: "Colors", windowPositionY: 180}


	engine.draw() # draw content
	###

	multiplication = 
		tapesContent: [
			"000000 000000000"
		]
		endState: 13
		functions: [
			(" ": [0 , " ", "R"], "0": [1 , " ", "R"])
			(" ": [2 , " ", "R"], "0": [1 , "0", "R"])
			(" ": [13, " ", "L"], "0": [3 , " ", "R"])
			(" ": [4 , " ", "R"], "0": [3 , "0", "R"])
			(" ": [5 , "0", "L"], "0": [4 , "0", "R"])
			(" ": [6 , " ", "L"], "0": [5 , "0", "L"])
			(" ": [8 , "0", "L"], "0": [7 , "0", "L"])
			(" ": [2 , "0", "R"], "0": [7 , "0", "L"])
			(" ": [9 , " ", "L"], "0": [8 , "0", "L"])
			(" ": [11, " ", "R"], "0": [10, "0", "L"])
			(" ": [0 , " ", "R"], "0": [10, "0", "L"])
			(" ": [11, " ", "R"], "0": [12, " ", "R"])
			(" ": [13, " ", "R"], "0": [12, " ", "R"])
		]
	setup = new SingleTapeSetup mashine: multiplication
	setup.init()
	
	

