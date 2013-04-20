#= require Queue.js
root = exports ? this

root.CanvasDrawer = class
	

	constructor: (@canvas, @scaleX, @scaleY, @colorSettings) ->
		@context = @canvas.getContext "2d"
		@history = []
		@historySize = 100
		@pixelPadding = 1
		@cursorBandOffset = 1

	draw: (band, bandIndex) ->
		#@clearCanvas()
		@drawCursor band, bandIndex
		@drawContent band, bandIndex


	drawCursor: (band, bandIndex) ->
		@clearRow @cursorBandOffset
		@drawPixel band.position, @cursorBandOffset, @colorSettings.cursorColor

	drawContent: (band, bandIndex) ->
		if @history.length >= @historySize
			@history.pop()
		@history.unshift band.printArray()
		

		for band, y in @history
			for char, x in band
				if @colorSettings.colorMappings[char]?
					color = @colorSettings.colorMappings[char]
					@drawPixel x,y+@cursorBandOffset+2, color 
				else
					@clearPixel x,y+@cursorBandOffset+2




	


	drawPixel: (x,y,color) ->
		@context.fillStyle = color;
		@context.fillRect x*@scaleX+@pixelPadding, y*@scaleY+@pixelPadding, 1*@scaleX-@pixelPadding, 1*@scaleY-@pixelPadding 
	clearPixel: (x,y) ->
		@context.clearRect x*@scaleX, y*@scaleY, 1*@scaleX, 1*@scaleY 
	clearRow: (y) ->
		@context.clearRect 0, y*@scaleY, canvas.width, 1*@scaleY 


	clearCanvas: ->
		@canvas.width = @canvas.width;