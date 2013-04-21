# better performance then the normal CanvasDrawer

#= require CanvasDrawer
root = exports ? this

root.CanvasDrawer2 = class extends root.CanvasDrawer 
	


	drawContent: (tape) ->
		
		@appendToHistory tape
		
		
		if @counter > 0 && @counter % @settings.historyScale == 0
			# create new canvas
			@initCanvas()
			@checkHistorySize()
		@checkCanvasBounds @contentCanvas, tape.getWidth(),1
		@drawRow @contentCanvas, tape.printArray(), 0
			

		

	checkHistorySize: ->
		$history = @$canvasContainer.find "canvas"
		
		if @settings.historySize > 0 && $history.length > @settings.historySize
			
			$history.last().remove()
			



					
	