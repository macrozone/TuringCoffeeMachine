root = exports ? this

root.FunctionRepo = class
	
	@addition: 
		tapes: 1
		endState: 5
		functions:
			[
				(" ": [0, " ", "R"], "0": [1, "0", "R"])
				(" ": [2, "0", "R"], "0": [1, "0", "R"])
				(" ": [3, " ", "L"], "0": [2, "0", "R"])
				(" ": [3, " ", "L"], "0": [4, " ", "L"])
				(" ": [5, " ", "R"], "0": [4, "0", "L"])
			]