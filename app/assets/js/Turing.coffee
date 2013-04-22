#= require Tape.coffee

root = exports ? this
root.Turing = class

	
	constructor: (mashineSettings) ->
		defaults = 
			startState: 0
			endState: "end"
			functions: []
		@mashineSettings = $.extend true, {}, defaults, mashineSettings
		
		@state = @mashineSettings.startState

		@tapes = (new Tape word for word in @mashineSettings.tapesContent)

	step: ->
		
		[@state, newTapeWord, tapeMoveWord] = @getFunction()
		@writeTapeColumn newTapeWord
		@moveTapes tapeMoveWord.split ""
		@finished()
	
	printAll: ->
		(tape.print() for tape in @tapes)
	printAllAsArrays: ->
		(tape.printArray() for tape in @tapes)

	printTapeColumn: ->
		(tape.read() ? " " for tape in @tapes).join ""

	writeTapeColumn: (word) ->
		for char, i in word.split ""
			if char == "" 
				char = undefined
			@tapes[i].write char 

	finished: ->
		@state == @mashineSettings.endState


	moveTapes: (tapeMoves) ->
		for move,i in tapeMoves
			switch move
				when "L" then @tapes[i].left()
				when "R" then @tapes[i].right()
	
	getFunction: ->
		@mashineSettings.functions[@state][@printTapeColumn()]





