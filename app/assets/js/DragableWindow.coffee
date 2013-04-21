#= require draggableWindow.jquery.coffee

root = exports ? this


root.DragableWindow = class
	windowDefaults:
		title: "Tape"
		
		colorSettings:
			backgroundColor: "black"
			
		windowPositionX: 10
		windowPositionY: 10
	
	constructor: (settings) ->
	
		@settings = $.extend true, {}, @windowDefaults, settings
		
		@initWindow()


	initWindow: ->
		@$window = $ '<div class="window" />'
		$title = $("<h2 class='title'>"+@settings.title+"</h2>")
		$title.appendTo @$window
		@$window.appendTo $ "body"
		@$window.draggableWindow(xOffset: @settings.windowPositionX, yOffset: @settings.windowPositionY)

		@$window.css "background-color", @settings.colorSettings.backgroundColor
		

