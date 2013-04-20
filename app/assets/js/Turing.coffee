#= require Band.coffee

root = exports ? this
root.Turing = class

	constructor: (@bands, @functions, @endState) ->
		@state = 0

	step: ->
		
		[@state, newBandWord, bandMoveWord] = @getFunction()
		@writeBandColumn newBandWord
		@moveBands bandMoveWord.split ""
		@finished()
	
	printAll: ->
		(band.print() for band in @bands)
	printAllAsArrays: ->
		(band.printArray() for band in @bands)

	printBandColumn: ->
		(band.read() ? " " for band in @bands).join ""

	writeBandColumn: (word) ->
		for char, i in word.split ""
			if char == "" 
				char = undefined
			@bands[i].write char 

	finished: ->
		@state == @endState


	moveBands: (bandMoves) ->
		for move,i in bandMoves
			switch move
				when "L" then @bands[i].left()
				when "R" then @bands[i].right()
	
	getFunction: ->
		#console.log @functions, @state, @functions[@state], @printBandColumn()
		@functions[@state][@printBandColumn()]





