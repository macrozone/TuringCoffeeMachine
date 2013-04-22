
root = exports ? this


root.Controller = class extends root.DragableWindow
	

	constructor: (@engine, windowSettings) ->
		super windowSettings
		@engine.addHaltListener @onHalt
		@engine.addStepListener @onStep

		@$window.addClass "controller"

		@initButtons()
		@initSpeed()

		@$state = $("<div class='state'></div>").appendTo @$window


	initButtons: ->
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
	initSpeed: ->
		$speedContainer = $ "<div class='speedControl' />"
		$speedContainer.append "<label>Speed: </label>"
		speed = @engine.settings.speed
		@$speed = $ "<input type='number' value='"+speed+"' />"
		@$speed.appendTo $speedContainer
		$speedContainer.appendTo @$window
		@$speed.on "change", => @setSpeedByWidget()
		@$speed.on "keyup", => @setSpeedByWidget()

	setSpeedByWidget: ->
		@engine.setSettings speed: @$speed.val()



	onHalt: (fullState) =>
		@$state.text @printFullState fullState
		@$playButton.show()
		@$pauseButton.hide()


	onStep: (fullState)=>
		@$state.text @printFullState fullState
		@$pauseButton.show()
		@$playButton.hide()

	printFullState: (state) ->
		"#{state.engineState} | step: #{state.step} | state: #{state.mashineState}"

