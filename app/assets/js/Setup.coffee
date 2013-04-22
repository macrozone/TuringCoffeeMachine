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
#= require CharCounterDrawer.coffee


root = exports ? this

root.Setup = class
	
	@defaultColorSettings: ->
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
			

		mashine: {}

	constructor: (settings) ->
		
		@settings = $.extend true, {}, @defaultSetup, settings
		
	
	init: ->
		@turing = new Turing @settings.mashine
		@engine = new Engine @turing
		
		for tapeIndex, settingArray of @settings.tapeDrawerSettings
			for setting in settingArray
	
				@engine.addDrawer (new CanvasDrawer2 setting), tapeIndex
		
		@engine.addDrawer (new CharCounterDrawer colorSettings: @settings.colorSettings,  windowPositionY: 280, title: "Char-Counter Tape 1"), 0
	
	

		new Controller @engine, title: "Controller"

		new ColorMappingWindow @settings.colorSettings.colorMappings, title: "Colors", windowPositionY: 180

		@engine.draw()


		