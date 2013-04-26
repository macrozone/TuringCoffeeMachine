#= require Setup

root = exports ? this


root.MultiTapeSetup = class extends root.Setup
	
	defaultTapeSettings: 
			title: "Tape #"
			scaleX: 10
			scaleY: 10
			colorSettings: @defaultColorSettings()
			windowPositionX: 280
			historyScale: 1
			historySize: -1
			pixelDrawMode: "char"
	

	constructor: (settings) ->
		defaults = 
			numberOfTapes: 1

			tapeDrawerSettings: []
		for i in [1..settings.numberOfTapes]
			tapeSettings = []
			
			setting = $.extend {}, @defaultTapeSettings # clone
			setting.title = setting.title.replace "#", i
	
			defaults.tapeDrawerSettings.push [setting]

		settings = $.extend true, {}, defaults, settings
		console.log settings
		

		

		super settings



	
