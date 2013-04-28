#= require DragableWindow

root = exports ? this

root.CanvasDrawer = class extends root.DragableWindow
	
	defaults:
		title: "Tape"
		scaleX: 5
		scaleY: 5
		colorSettings:
			cursorColor: "white"
			fadeTrashhold: 0.75 #only supported for CanvasDrawer 1
			colorMappings: {}
		pixelPadding: 1
	
		historyScale: 1 # gaps in history
		historySize: -1 # -1 means infinite


	constructor: (settings) ->
		super(settings)
		@settings = $.extend true, {}, root.DragableWindow.defaults, @defaults, settings
		

		@counter = 0
		@history = []
		@cursorOffset = 0
		@contentOffset = 0

		@initCursorCanvas()
		@initCanvasContainer()
		@initCanvas()
		

	draw: (tape, tapeIndex) ->

		if tape.position < -@cursorOffset
			@cursorOffset = -tape.position
		
		@contentOffset = @cursorOffset- tape.getLeftWidth()
		@drawCursor tape
		@drawContent tape
		@counter++

	checkCanvasBounds: (canvas, width, height) ->
	
		
		width *= @settings.scaleX
		height *= @settings.scaleY
	
		if canvas.width < width
			canvas.width = width
		if canvas.height < height
			canvas.height = height

	drawCursor: (tape) ->
		canvas = @cursorCanvas
		
		@checkCanvasBounds canvas, @cursorOffset+tape.position+1, 1
		@clearRow canvas, 0
		@drawCharPixel canvas, tape.position+@cursorOffset, 0, @settings.colorSettings.cursorColor, "▼"

	drawContent: (tape) ->
		canvas = @contentCanvas
		@checkCanvasBounds canvas, tape.getWidth(), @history.length/ @settings.historyScale 
		@appendToHistory tape
		@drawHistory canvas

	drawHistory: (canvas)->
		for tape, y in @history by @settings.historyScale
			y /= @settings.historyScale
			@drawRow canvas, tape, y

	appendToHistory: (tape) ->

		if @settings.historySize > 0 && @history.length >= @settings.historySize * @settings.historyScale
			# remove last
			@history.pop()
		@history.unshift tape

	drawRow: (canvas, tape, row) ->

		for char, x in tape.printArray()
			x += @contentOffset
			if char?
				@drawContentPixel canvas, x, row, char, tape.lastPosition
			else
				@clearPixel canvas, x,row
				
					

					
	getColorForChar: (char, y) ->
		color = @settings.colorSettings.colorMappings[char] ? @settings.colorSettings.colorMappings.fallback
		
		progress = y/@settings.historySize

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

    drawContentPixel: (canvas, x,y, char, tapePosition) ->
    	color = @getColorForChar char, y
    	# shade if cursor is here
    	
    	color = @shadeColor color, @settings.colorSettings.currentPositionShade if x == tapePosition+@cursorOffset
    	switch @settings.pixelDrawMode
    		
    		when "char" then @drawCharPixel canvas, x,y, color, char
    		else @drawPixel canvas, x,y, color

	drawPixel: (canvas, x,y,color) ->

		canvas.getContext("2d").fillStyle = color;
		canvas.getContext("2d").fillRect x*@settings.scaleX+@settings.pixelPadding, y*@settings.scaleY+@settings.pixelPadding, 1*@settings.scaleX-@settings.pixelPadding, 1*@settings.scaleY-@settings.pixelPadding 
	drawCharPixel: (canvas, x,y,color, char) ->
		
		canvas.getContext("2d").font = @settings.scaleY+"pt monospace"
		canvas.getContext("2d").fillStyle = color;
		canvas.getContext("2d").fillText char, x*@settings.scaleX, (y+1)*@settings.scaleY, 1*@settings.scaleX, 1*@settings.scaleY 
	

	clearPixel: (canvas, x,y) ->
		canvas.getContext("2d").clearRect x*@settings.scaleX, y*@settings.scaleY, 1*@settings.scaleX, 1*@settings.scaleY 
	clearRow: (canvas, y) ->
		canvas.getContext("2d").clearRect 0, y*@settings.scaleY, canvas.width, 1*@settings.scaleY 


	clearCanvas: ->
		@canvas.width = @canvas.width;

	initCanvas: ->
	
		@contentCanvas = document.createElement "canvas"
		@contentCanvas.width = 0
		@contentCanvas.height = 0
		@$canvasContainer.prepend $ @contentCanvas
		@contentCanvas

	initCursorCanvas: ->
		@cursorCanvas = document.createElement "canvas"
		@cursorCanvas.width = 0
		@cursorCanvas.height = 0

	initCanvasContainer: ->
		@$content.append $(@cursorCanvas).addClass "cursorCanvas"
		@$canvasContainer = $ "<div class='canvasContainer' />"
		@$canvasContainer.appendTo @$content
	


