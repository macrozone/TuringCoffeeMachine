
root = exports ? this


root.Controller = class extends root.DragableWindow
	

	constructor: (@engine, windowSettings) ->
		super windowSettings
		@engine.addHaltListener @onHalt
		@engine.addStepListener @onStep

		@$window.addClass "controller"

		@$buttonContainer = $ "<div />"
		@$buttonContainer.appendTo @$window
		@$playButton = $("<a class='playButton button'>▶</a>").appendTo @$buttonContainer

		@$pauseButton = $("<a class='pauseButton button'> | | </a>").appendTo @$buttonContainer
		@$pauseButton.hide()
		@$stepButton = $("<a class='playButton button'>▶|</a>").appendTo @$buttonContainer
		

		@$playButton.on "click", =>

			@engine.run()
		@$pauseButton.on "click", =>
			@engine.pause()
		@$stepButton.on "click", =>
			@engine.pause()
			@engine.step()
		@$window.append "<span>Speed: </speed>"
		speed = @engine.settings.speed
		@$speed = $ "<input type='number' value='"+speed+"' />"
		@$speed.appendTo @$window
		@$speed.on "change", => @setSpeedByWidget()
		@$speed.on "keyup", => @setSpeedByWidget()
		@$state = $("<p class='state'></p>").appendTo @$window

	setSpeedByWidget: ->
		@engine.setSettings speed: @$speed.val()



	onHalt: (haltState) =>
		@$state.text haltState
		@$playButton.show()
		@$pauseButton.hide()


	onStep: =>
		@$state.text "running"
		@$pauseButton.show()
		@$playButton.hide()


