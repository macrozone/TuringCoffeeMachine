
root = exports ? this


root.SetupWindow = class extends root.DragableWindow
	

	samples:
		"Multiplication": 
			tapesContent: ["000000 0000"]
			startState: 0
			endState: "end"
			functions: 
				0: (" ": [0 , " ", "R"], "0": [1 , " ", "R"])
				1: (" ": [2 , " ", "R"], "0": [1 , "0", "R"])
				2: (" ": [13, " ", "L"], "0": [3 , " ", "R"])
				3: (" ": [4 , " ", "R"], "0": [3 , "0", "R"])
				4: (" ": [5 , "0", "L"], "0": [4 , "0", "R"])
				5: (" ": [6 , " ", "L"], "0": [5 , "0", "L"])
				6: (" ": [8 , "0", "L"], "0": [7 , "0", "L"])
				7: (" ": [2 , "0", "R"], "0": [7 , "0", "L"])
				8: (" ": [9 , " ", "L"], "0": [8 , "0", "L"])
				9: (" ": [11, " ", "R"], "0": [10, "0", "L"])
				10: (" ": [0 , " ", "R"], "0": [10, "0", "L"])
				11: (" ": [11, " ", "R"], "0": [12, " ", "R"])
				12: (" ": ["end", " ", "R"], "0": [12, " ", "R"])
		"0^x1^x":
			tapesContent: [
				"000000000000000000000000000000000000000000000000111111111111111111111111111111111111111111111111"
			]
			endState: 4
			functions: [
				("0": [1, "X", "R"], "Y": [3, "Y", "R"])
				("0": [1, "0", "R"], "Y": [1, "Y", "R"], "1": [2, "Y", "L"])
				("0": [2, "0", "L"], "Y": [2, "Y", "L"], "X": [0, "X", "R"])
				("Y": [3, "Y", "R"], " ": [4, " ", "R"])
			]



	constructor: (@engine, windowSettings) ->
		defaults = 
			class: "setup"
			title: "Setup"
		super $.extend true, {}, defaults, windowSettings

		
		@$setupChoser = {}
	
		@$samples = $ "<select></select>"
		@$samples.append "<option>Samples</option>" 
		for key of @samples
	
			@$samples.append "<option value='"+key+"''>"+key+"</option>" 

		@$samples.on "change", =>
			key = @$samples.val()
			sample = @samples[key]
			console.log sample
			@$mashineCode.val JSON.stringify sample

		@$samples.appendTo @$content
		@$content.append $ "<p> mashineCode (json):</p>"
		@$mashineCode = $ "<textarea />"
		@$mashineCode.appendTo @$content
		@$content.append $ "<br />"

		$initButton = $ "<a class='button'>init</a>"
		@$content.append $initButton
		@$content.append $ "<br />"

		$initButton.on "click", => @init()

		


		

	init: ->
		@setup.destroy() if @setup?

		mashineCode = $.parseJSON @$mashineCode.val()
		numberOfTapes = mashineCode.tapesContent.length



		if numberOfTapes == 1 
			@setup = new SingleTapeSetup mashine: mashineCode
		else 
			@setup = new MultiTapeSetup mashine: mashineCode, numberOfTapes: numberOfTapes

	
		@setup.init()

