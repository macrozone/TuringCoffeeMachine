root = exports ? this
root.Engine = class


	constructor: (@turing, @stepTime) ->
		@drawers = []

	setStepTime: (@stepTime) ->

	addDrawer: (drawer) ->
		@drawers.push drawer

	run: ->
		# draw initial
		@draw()
		if @stepTime < 0
			@loopRun()
		else
			@stepRun()


	loopRun: ->
		while not @turing.finished()
			@step()
		console.log "finished"

	stepRun: =>

		unless @turing.finished()
			@step()
			setTimeout @stepRun, @stepTime
		else
			console.log "finished"

	step: ->
		@turing.step()
		@draw()

	draw: ->
		drawer.draw @turing for drawer in @drawers