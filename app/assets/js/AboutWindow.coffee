
root = exports ? this


root.AboutWindow = class extends root.DragableWindow
	
	
	constructor: (windowSettings) ->
		defaults = 
			title: "About"
		super $.extend true, {}, defaults, windowSettings
		@$content.append $ "<p>A Multi Tape TuringMachine Simulator<br/>written in coffeescript</p>"
		$list = $ '<ul />'
		@$content.append $list

		$list.append '<li><a target="_blank" href="https://github.com/macrozone/TuringCoffeeMachine">fork me on github</a></li>'	
		$list.append '<li><a target="_blank"  href="http://en.wikipedia.org/wiki/Turing_machine">wikipedia Turing Machine</a></li>'
		