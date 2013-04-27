#= require SingleTapeSetup.coffee

root = exports ? this


root.MultiplicationSingleTapeSetup = class extends root.SingleTapeSetup
	

	constructor: (a, b, settings) ->

		@machine = 
			tapesContent: 
				[
					@createUnaryTapeContent a,b, "0"
				]
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


		super machine: @machine



