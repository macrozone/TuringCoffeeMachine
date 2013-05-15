
root = exports ? this


root.SetupWindow = class extends root.DragableWindow
	

	samples:

		"Faculty 3 tapes":
			tapesContent: ["00000", "", ""]
			startState: "q0"
			endState: "end"
			functions:
				# t2 = t1 -1
				"q0": ("0  ": ["q1", "0  ", "RRS"], "   ": ["end", "0  ", "SSS"])
				"q1": ("0  ": ["q1", "00 ", "RRS"], "   ": ["q2", "   ", "LLS"])
				"q2": ("00 ": ["q2", "00 ", "LLS"], "0  ": ["q3", "0  ", "SRS"])



				# multiplication t1 * t2 -> t3
				"q3": ("00 ": ["q3", "000", "SRR"], "0  ": ["q4", "0  ", "SLS"], " 0 ": ["q9", "   ", "SRS"], "   ": ["end", "0  ", "SSS"])
				"q4": ("00 ": ["q4", "00 ", "SLS"], "0  ": ["q3", "   ", "RRS"])

				# multiplication t3 * t2 -> t1
				"q5": (" 00": ["q5", "000", "RRS"], "  0": ["q6", "  0", "SLS"], " 0 ": ["q7", "   ", "SRS"])
				"q6": (" 00": ["q6", " 00", "SLS"], "  0": ["q5", "   ", "SRL"])
				

				# check if tape 2 greater then 1
				"q7": (" 0 ": ["q8", " 0 ", "SRS"])
				"q8": (" 0 ": ["rewind", " 0 ", "LLS"], "   ": ["end", "   ", "SRS"])

				# check if tape 2 greater then (from other state)
				"q9": (" 0 ": ["q10", " 0 ", "SRS"], "   ": ["end", "   ", "SSS"])
				"q10": (" 0 ": ["q5", " 0 ", "SLL"], "   ": ["end", "   ", "SRS"])

				# rewind t1
				"rewind": ("00 ": ["rewind", "00 ", "LSS"], " 0 ": ["q3", " 0 ", "RSS"])


		"Multiplication 3 tapes":
			tapesContent: ["0000", "0000000", ""]
			startState: "q0"
			endState: "end"
			functions:
				"q0": ("00 ": ["q0", "000", "SRR"], "0  ": ["q1","0  ", "SLS"], " 0 ": ["end", " 0 ", "SLS"] , "   ": ["end", "   ", "SLS"])
				"q1": ("00 ": ["q1", "00 ", "SLS"], "0  ": ["q0", "   ", "RRS"])

		"Multiplication": 
			tapesContent: ["0000 0000000"]
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
			@$machineCode.val @stringify sample

		@$samples.appendTo @$content
		@$content.append $ "<p> machineCode (json):</p>"
		@$machineCode = $ "<textarea />"
		@$machineCode.appendTo @$content
		@$content.append $ "<br />"
		$pretty = $ "<a>format</a>"
		$pretty.on "click", => @prettyMachineCode()
		@$content.append $pretty
		@$content.append $ "<br />"

		$initButton = $ "<a class='button'>Initialize / Reset Machine</a>"
		@$content.append $initButton
		@$content.append $ "<br />"

		$initButton.on "click", => @init()

	prettyMachineCode: ->
		code = @$machineCode.val()
		code = @prettyfyJsonString code
		@$machineCode.val code

	prettyfyJsonString: (string) ->
		object = $.parseJSON string
		@stringify object
		
	stringify: (object) ->
		string = JSON.stringify object, undefined, 2
		string.replace /(\[[^\]^\{]*\])/g, (match) =>
			@removeLineBreaksAndWhiteSpace match

	removeLineBreaksAndWhiteSpace: (string) ->
		string = string.replace /\r?\n|\r/g , ""
		string = string.replace /\[\s*/g , "[ "
		string = string.replace /\,\s*/g , ", "
		string = string.replace /\s*\]/g , " ]"

	

	init: ->
		@setup.destroy() if @setup?

		machineCode = $.parseJSON @$machineCode.val()
		numberOfTapes = machineCode.tapesContent.length


		if numberOfTapes == 1 
			@setup = new SingleTapeSetup machine: machineCode
		else 
			@setup = new MultiTapeSetup machine: machineCode, numberOfTapes: numberOfTapes

	
		@setup.init()

