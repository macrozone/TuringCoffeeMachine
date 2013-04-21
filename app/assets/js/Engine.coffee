root = exports ? this
root.Engine = class

	defaults:
		speed: 100
		

	constructor: (@turing, settings) ->
		@setSettings settings
		@drawers = []
		@haltListener = []
		@stepListener = []
		@invalidState = false

	setSettings: (settings) ->
		@settings = $.extend true, {}, @defaults, settings

	addHaltListener: (l) ->
		@haltListener.push l

	addStepListener: (l) ->
		@stepListener.push l


	addDrawer: (drawer, bandIndex) ->
		unless @drawers[bandIndex]? 
			@drawers[bandIndex] = []
		@drawers[bandIndex].push drawer

	

	run: ->
		@paused = false
		
		if @settings.speed < 0
			@loopRun()
		else
			@stepRun()

	pause: ->
		@paused = true

	hasHalted: ->
		halted = @paused || @invalidState || @turing.finished() 
		if @paused
			haltState = "paused"
		if @invalidState
			haltState = "invalid state"
		if @turing.finished()
			haltState = "finished"
		
		if halted
			l(haltState) for l in @haltListener
		halted


	loopRun: ->
		while not @hasHalted()
			@step()

	stepRun: =>

		unless @hasHalted()
			l() for l in @stepListener
			@step()
			setTimeout @stepRun, @getStepTimeout()

	getStepTimeout: ->
		Math.floor 1000/@settings.speed

	step: ->
		try
			multiSteps = Math.floor @settings.speed /1000
			for i in [0..multiSteps-1]
				@turing.step()
				@draw()
				if @hasHalted() 
					break
		catch e
			@invalidState = true

	draw: ->
		for tape, index in @turing.tapes
			if @drawers[index]?
				for drawer in @drawers[index]
					drawer.draw tape, index