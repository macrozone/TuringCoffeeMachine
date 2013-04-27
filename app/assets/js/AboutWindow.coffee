
root = exports ? this


root.AboutWindow = class extends root.DragableWindow
	
	
	constructor: (windowSettings) ->
		defaults = 
			title: "About"
		super $.extend true, {}, defaults, windowSettings
		@$content.append $ "<p>A Multi Tape TuringMashine Simulator<br/>written in coffeescript</p>"
		$list = $ '<ul />'
		@$content.append $list

		$list.append '<li><a target="_blank" href="https://github.com/macrozone/TuringCoffeeMashine">fork me on github</a></li>'	
		$list.append '<li><a target="_blank"  href="http://en.wikipedia.org/wiki/Turing_machine">wikipedia Turing Mashine</a></li>'
		