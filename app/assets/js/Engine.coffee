root = exports ? this
root.Engine = class


	constructor: (@turing, @stepTime) ->
		@drawers = []


	setStepTime: (@stepTime) ->

	addDrawer: (drawer, bandIndex) ->
		unless @drawers[bandIndex]? 
			@drawers[bandIndex] = []
		@drawers[bandIndex].push drawer

	run: ->
		@halted = false
		# draw initial
		@draw()
		if @stepTime < 0
			@loopRun()
		else
			@stepRun()

	hasHalted: ->
		@halted || @turing.finished() 

	loopRun: ->
		while not @hasHalted()
			@step()
		console.log "finished"

	stepRun: =>

		unless @hasHalted()
			@step()
			setTimeout @stepRun, @stepTime
		else
			console.log "finished"

	step: ->
		try
			@turing.step()
			@draw()
		catch e
			@halted = true

	draw: ->
		for tape, index in @turing.tapes
			if @drawers[index]?
				for drawer in @drawers[index]
					drawer.draw tape, index