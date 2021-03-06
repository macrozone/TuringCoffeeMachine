#= require Setup

root = exports ? this


root.SingleTapeSetup = class extends root.Setup
	
	defaults: 
		tapeDrawerSettings:
			[
				[
					title: "Tape 1"
					scaleX: 10
					scaleY: 10
					colorSettings: @defaultColorSettings()
					windowPositionX: 420
					historyScale: 1
					historySize: -1
					pixelDrawMode: "char"
				,

					title: "Tape 1 - 10x"
					colorSettings: @defaultColorSettings()
					windowPositionX: 980
					historyScale: 10
				,

					title: "Tape 1 - 100x"
					colorSettings: @defaultColorSettings()
					windowPositionX: 1200
					historyScale: 100
				]
			]

	constructor: (settings) ->
	
		settings = $.extend true, {}, @defaults, settings
		super settings



	
