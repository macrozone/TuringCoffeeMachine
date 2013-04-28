#= require Tape.coffee

root = exports ? this
root.Turing = class

	constructor: (machineSettings) ->
		defaults = 
			startState: 0
			endState: "end"
			functions: []
		@machineSettings = $.extend true, {}, defaults, machineSettings
		@state = @machineSettings.startState
		@tapes = (new Tape word for word in @machineSettings.tapesContent)

	step: ->
		[@state, newTapeWord, tapeMoveWord] = @getFunction()
		@writeTapeColumn newTapeWord
		@moveTapes tapeMoveWord.split ""
	
	printAll: ->
		(tape.print() for tape in @tapes)

	printAllAsArrays: ->
		(tape.printArray() for tape in @tapes)

	printTapeColumn: ->
		(tape.read() ? " " for tape in @tapes).join ""

	writeTapeColumn: (word) ->
		for char, i in word.split ""
			if char == " " 
				char = undefined
			@tapes[i].write char 

	finished: ->
		@state == @machineSettings.endState

	moveTapes: (tapeMoves) ->
		for move,i in tapeMoves
			switch move
				when "L" then @tapes[i].left()
				when "R" then @tapes[i].right()
				else @tapes[i].stay()
	
	getFunction: ->
		@machineSettings.functions[@state][@printTapeColumn()]





