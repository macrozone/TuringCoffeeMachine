
root = exports ? this


root.EngineControllerWindow = class extends root.DragableWindow
	

	constructor: (@engine, windowSettings) ->
		defaults = 
			class: "controller"
			title: "Controller"
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
		
		
		@$state = $("<div class='state'></div>").appendTo @$content
		@$previousFunction = $("<span class='function previous'></span>").appendTo $("<p><span class='label'>Previous:</span></p>").appendTo @$state
		@$stateText = $("<span class='stateText'>ready</span>").appendTo $("<p><span class='label'></span></p>").appendTo @$state
		@$nextFunction = $("<span class='function next'></span>").appendTo $("<p><span class='label'>Next:</span></p>").appendTo @$state
		@setFunctionTexts()

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
		
		@$buttonContainer.append "<label>Speed: </label>"
		speed = @engine.settings.speed
		@$speed = $ "<input type='number' value='"+speed+"' />"
		@$speed.appendTo @$buttonContainer
		
		@$speed.on "change", => @setSpeedByWidget()
		@$speed.on "keyup", => @setSpeedByWidget()

	setSpeedByWidget: ->
		@engine.setSettings speed: @$speed.val()



	onHalt: (fullState) =>
		@setStateText fullState
		@$playButton.show()
		@$pauseButton.hide()


	onStep: (fullState)=>
		@setFunctionTexts()
		@setStateText fullState
		@$pauseButton.show()
		@$playButton.hide()

	setStateText: (fullState) ->
		state = @printFullState fullState
		@$stateText.text state

		@$stateText.css "color", @getColor fullState.engineState

	printFullState: (state) ->
		"#{state.engineState} | step: #{state.step} | state: #{state.machineState}"

	setFunctionTexts: ->
		@setPreviousFunctionText()
		@setNextFunctionText()
	setPreviousFunctionText: ->
		@$previousFunction.text @$nextFunction.text()

	setNextFunctionText: ->
		@$nextFunction.text @getFunctionText()

	getFunctionText: ->
		try
			state = @engine.turing.state
			currentFunction = @engine.turing.getFunction()
			tapeWord = @engine.turing.printTapeColumn()
			"(#{state},\"#{tapeWord}\") -> (#{currentFunction[0]},\"#{currentFunction[1]}\",#{currentFunction[2]})"
		catch e
			""

	getColor: (state) ->
		@settings.colorSettings.engineStateColors[state]



