#= require draggableWindow.jquery.coffee

root = exports ? this


root.DragableWindow = class
	windowDefaults:
		title: "Tape"
		class: "default-window"
		colorSettings:
			backgroundColor: "black"
			
		windowPositionX: 10
		windowPositionY: 10
	

	
	constructor: (settings) ->
	
		@settings = $.extend true, {}, @windowDefaults, settings
		
		@initWindow()


	initWindow: ->
		@$window = $ '<div class="window '+@settings.class+'" />'
		@$window.draggableWindow(xOffset: @settings.windowPositionX, yOffset: @settings.windowPositionY)
		@$window.appendTo $ "body"
		@$window.css "background-color", @settings.colorSettings.backgroundColor


		@$header = $ '<div class="header" />'
		@$header.appendTo @$window
		$title = $("<h2 class='title'>"+@settings.title+"</h2>")	
		$title.appendTo @$header
		@$window.on "mousedown", =>
			@lastOffset = @$window.offset()

		$title.on "click", =>
			# toggle only if not moved
			offset = @$window.offset()
			if offset.left == @lastOffset.left and offset.top == @lastOffset.top
				@$content.toggle()
		
		
		
		
		@$content = $ '<div class="content" />'
		@$content.appendTo @$window

	dismiss: ->
		@$window.remove()
		

