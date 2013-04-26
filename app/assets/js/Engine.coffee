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
		@stepCounter = 0

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
		drawer
	

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
		
		if halted
			l @getFullState()  for l in @haltListener
		halted

	getEngineState: ->
		return "paused" if @paused
		return "invalid state" if @invalidState
		return "finished" if @turing.finished()
		return "running"
		
	getFullState: ->
		engineState: @getEngineState()
		mashineState: @turing.state
		step: @stepCounter


	loopRun: ->
		while not @hasHalted()
			@step()

	stepRun: =>

		unless @hasHalted()
			@step()
			setTimeout @stepRun, @getStepTimeout()

	getStepTimeout: ->
		Math.floor 1000/@settings.speed

	step: ->
		try
			multiSteps = Math.floor @settings.speed /1000
			# speeds >= 2000 will result in multiple executions per event-loop
			for i in [0..multiSteps-1]
				@turing.step()
				@draw()
				@stepCounter++
				l @getFullState() for l in @stepListener
				
				if @hasHalted() 
					break
			
			
		catch e
			@invalidState = true

	draw: ->
		for tape, index in @turing.tapes
			if @drawers[index]?
				for drawer in @drawers[index]
					drawer.draw tape, index



