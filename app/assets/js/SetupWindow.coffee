
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
			functions: 
				0:("0": [1, "X", "R"], "Y": [3, "Y", "R"])
				1:("0": [1, "0", "R"], "Y": [1, "Y", "R"], "1": [2, "Y", "L"])
				2:("0": [2, "0", "L"], "Y": [2, "Y", "L"], "X": [0, "X", "R"])
				3:("Y": [3, "Y", "R"], " ": [4, " ", "R"])
			
		"3bandtest":
			tapesContent: [
                "000000000000000000000111111111111111111111",
                "XXXXXXXXXXXXXXXXXXXXXYYYYYYYYYYYYYYYYYYYYY",
                "000000000000000000000111111111111111111111"
            ]
            endState: 4
            functions: 
               0: ("0X0": [1, "X0X", "RRR"], "Y1Y": [3, "Y1Y", "RRR"])
               1: ("0X0": [1, "0X0", "RRR"], "Y1Y": [1, "Y1Y", "RRR"], "1Y1": [2, "Y1Y", "LLL"])
               2: ("0X0": [2, "0X0", "LLL"], "Y1Y": [2, "Y1Y", "LLL"], "X0X": [0, "X0X", "RRR"])
               3: ("Y1Y": [3, "Y1Y", "RRR"], "   ": [4, "   ", "RRR"])
            



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
			@$mashineCode.val @stringify sample

		@$samples.appendTo @$content
		@$content.append $ "<p> mashineCode (json):</p>"
		@$mashineCode = $ "<textarea />"
		@$mashineCode.appendTo @$content
		@$content.append $ "<br />"

		$initButton = $ "<a class='button'>Initialize / Reset Mashine</a>"
		@$content.append $initButton
		@$content.append $ "<br />"

		$initButton.on "click", => @init()

		
	stringify: (object) ->
		string = JSON.stringify object, undefined, 4
		string.replace /(\[[^\]^\{]*\])/g, (match) =>
			@removeLineBreaksAndWhiteSpace match

	removeLineBreaksAndWhiteSpace: (string) ->
		string = string.replace /\r?\n|\r/g , ""
		string = string.replace /\[\s*/g , "[ "
		string = string.replace /\,\s*/g , ", "
		string = string.replace /\s*\]/g , " ]"


		

	init: ->
		@setup.destroy() if @setup?

		mashineCode = $.parseJSON @$mashineCode.val()
		numberOfTapes = mashineCode.tapesContent.length



		if numberOfTapes == 1 
			@setup = new SingleTapeSetup mashine: mashineCode
		else 
			@setup = new MultiTapeSetup mashine: mashineCode, numberOfTapes: numberOfTapes

	
		@setup.init()

