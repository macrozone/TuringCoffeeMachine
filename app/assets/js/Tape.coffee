root = exports ? this
root.Tape = class


	constructor: (startWord)->
		@leftPart = []
		@rightPart = @wordToArray startWord
		@position = 0
		@lastPosition = 0

	stay: ->
		@lastPosition = @position
	left: ->
		@lastPosition = @position
		--@position
		
	right: ->
		@lastPosition = @position
		++@position

	read: ->
		if @position <0
			@leftPart[-@position-1]
		else
			@rightPart[@position]

	write: (char) ->
		if @position <0
			@leftPart[-@position-1] = char
		else
			@rightPart[@position] = char

	print: ->
		string = ""
		for char in @printArray()
			string += char ? " "
		string

	printArray: ->
		@leftPart.reverse().concat @rightPart

	wordToArray: (word) ->
		(@sanitizeChar char for char in word.split "")

	sanitizeChar: (char) ->
		if char != " " then char else undefined

	getWidth: ->
		@getLeftWidth()+ @getRightWidth()

	getLeftWidth: ->
		@leftPart.length

	getRightWidth: ->
		@rightPart.length