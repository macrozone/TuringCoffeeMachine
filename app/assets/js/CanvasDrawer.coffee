#= require draggableWindow.jquery.coffee
root = exports ? this

root.CanvasDrawer = class
	

	constructor: (@settings) ->
		
		@historySize = 100
		
		@contentYOffset = 3
		@cursorYPosition = 1

		@$canvasContainer = $ '<div class="canvasContainer" />'
		$title = $("<h2 class='title'>"+@settings.title+"</h2>")
		$title.appendTo @$canvasContainer
		@$canvasContainer.appendTo $ "body"
		@$canvasContainer.draggableWindow(xOffset: settings.windowXOffset, yOffset: settings.windowYOffset)


		@$canvasContainer.css "background-color", @settings.colorSettings.backgroundColor

		minWidth = 0
		minHeight = 0

		@canvas = document.createElement "canvas"
		@canvas.width = minWidth
		@canvas.height = minHeight
		@$canvasContainer.append $ @canvas

		@context = @canvas.getContext "2d"
		@history = []
		
		

	draw: (tape, tapeIndex) ->
		@checkCanvasBounds tape
		@drawCursor tape
		@drawContent tape


	checkCanvasBounds: (tape) ->
		width = tape.getWidth() * @settings.scaleX
		height = (@contentYOffset + Math.ceil(@history.length/ @settings.historySteps ))* @settings.scaleY
		if @canvas.width < width
			@canvas.width = width
		if @canvas.height < height
			@canvas.height = height

	drawCursor: (tape) ->
		@clearRow @cursorYPosition
		@drawPixel tape.position, @cursorYPosition, @settings.colorSettings.cursorColor

	drawContent: (tape) ->
		if @history.length >= @historySize * @settings.historySteps
			@history.pop()
		@history.unshift tape.printArray()
		

		for tape, y in @history by @settings.historySteps
			y /= @settings.historySteps
			for char, x in tape

				if @settings.colorSettings.colorMappings[char]?
					color = @getColorForChar char, y
					@drawPixel x,y+@contentYOffset, color 
				else
					@clearPixel x,y+@contentYOffset

					
	getColorForChar: (char, y) ->
		color = @settings.colorSettings.colorMappings[char]
		progress = y/@historySize
	
		if progress > @settings.colorSettings.fadeTrashhold
			@shadeColor(color, -(progress- @settings.colorSettings.fadeTrashhold)/(1-@settings.colorSettings.fadeTrashhold) * 100)
		else 
			color
		
	shadeColor: (color, percent) ->

   		num = parseInt(color.slice(1),16)

   		amt = Math.round(2.55 * percent)
   	
   		R = (num >> 16) + amt
   		B = (num >> 8 & 0x00FF) + amt
   		G = (num & 0x0000FF) + amt
   	
    	#"#" + (0x1000000 + (if R<255 then (if R<1 then 0 else R) else 255)*0x10000 + (if B<255 then (if B<1 then 0 else B) else 255)*0x100 + (if G<255 then (if G<1 then 0 else G) else 255)).toString(16).slice(1)
    	"rgb("+R+", "+B+", "+G+")"

	drawPixel: (x,y,color) ->
		@context.fillStyle = color;
		@context.fillRect x*@settings.scaleX+@settings.pixelPadding, y*@settings.scaleY+@settings.pixelPadding, 1*@settings.scaleX-@settings.pixelPadding, 1*@settings.scaleY-@settings.pixelPadding 
	clearPixel: (x,y) ->
		@context.clearRect x*@settings.scaleX, y*@settings.scaleY, 1*@settings.scaleX, 1*@settings.scaleY 
	clearRow: (y) ->
		@context.clearRect 0, y*@settings.scaleY, @canvas.width, 1*@settings.scaleY 


	clearCanvas: ->
		@canvas.width = @canvas.width;