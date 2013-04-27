#= require ../draggableWindow.jquery.coffee
#= require ../Turing.coffee
#= require ../Engine.coffee
#= require ../Tape.coffee
#= require ../DragableWindow
#= require ../ColorMappingWindow
#= require ../EngineControllerWindow
#= require ../ConsoleDrawer.coffee
#= require ../CanvasDrawer.coffee
#= require ../CanvasDrawer2.coffee
#= require ../CharCounterDrawer.coffee


root = exports ? this

root.Setup = class
	
	@defaultColorSettings: ->
		currentPositionShade: 20
		colorMappings:
			"0": "#FE906E"
			"1": "#FEDC6E"
			"X": "#6EFEDC"
			"Y": "#6E88FE"
			fallback: "#fff"
	defaultSetup:
		name: "Default-Setup"
		colorSettings: @defaultColorSettings()
		
		tapeDrawerSettings:
			0: []
			1: []
			2: []
			

		machine: {}



	constructor: (settings) ->
		
		@settings = $.extend true, {}, @defaultSetup, settings
		@windows = []
		
	
	destroy: ->
		@engine.pause() if @engine?
		@dismissAllWindows()

	init: ->
		@destroy()
		@turing = new Turing @settings.machine
		@engine = new Engine @turing
		counter = 0
		for tapeIndex, settingArray of @settings.tapeDrawerSettings
			for setting in settingArray
				setting.windowPositionX +=counter*320
				@addWindow @engine.addDrawer (new CanvasDrawer2 setting), tapeIndex
			charCounter = new CharCounterDrawer colorSettings: @settings.colorSettings,  windowPositionX: 440+counter*320, windowPositionY: 600, title: "Char-Counter Tape #{counter+1}"
			@addWindow @engine.addDrawer charCounter, counter
			counter++
		
	
	

		@addWindow new EngineControllerWindow @engine, windowPositionY: 500

		@addWindow new ColorMappingWindow @settings.colorSettings.colorMappings, windowPositionX: 440, windowPositionY: 500

		@engine.draw()

	createUnaryTapeContent: (a,b,char) ->
		word = ""
		word += @createUnaryNumber a, char
		word += " "
		word += @createUnaryNumber b, char

	createUnaryNumber: (number, char) ->
		word = ""
		for i in [1..number]
			word += char
		word
	
	addWindow: (aWindow) ->
		@windows.push aWindow

	


	dismissAllWindows: ->
		aWindow.dismiss() for aWindow in @windows


		