
root = exports ? this


root.EngineControllerWindow = class extends root.DragableWindow
	

	constructor: (@engine, windowSettings) ->
		defaults = 
			class: "controller"
			title: "Engine-Controller"
			colorSettings:
				engineStateColors:
					"paused": "#ff69b4"
					"invalid state": "#FFA49E"
					"finished": "#87AAFE"
					"running": "#87FED4"
		super $.extend true, {}, defaults, windowSettings
		@engine.addHaltListener @onHalt
		@engine.addStepListener @onStep

	

		@initButtons()
		@initSpeed()

		@$state = $("<p class='state'>ready</p>").appendTo @$content


	initButtons: ->
		@$buttonContainer = $ "<div />"
		@$buttonContainer.appendTo @$content
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
		$speedContainer.appendTo @$content
		@$speed.on "change", => @setSpeedByWidget()
		@$speed.on "keyup", => @setSpeedByWidget()

	setSpeedByWidget: ->
		@engine.setSettings speed: @$speed.val()



	onHalt: (fullState) =>
		@setStateText fullState
		@$playButton.show()
		@$pauseButton.hide()


	onStep: (fullState)=>
		@setStateText fullState
		@$pauseButton.show()
		@$playButton.hide()

	setStateText: (fullState) ->
		state = @printFullState fullState
		@$state.text state

		@$state.css "color", @getColor fullState.engineState

	printFullState: (state) ->
		"#{state.engineState} | step: #{state.step} | state: #{state.mashineState}"

	getColor: (state) ->
		@settings.colorSettings.engineStateColors[state]



