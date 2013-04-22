#= require DragableWindow

root = exports ? this

root.CharCounterDrawer = class extends root.DragableWindow
	
	defaults:
		title: "Char-Count"
		colorSettings:
			colorMappings: {}
		


	constructor: (settings) ->
		settings = $.extend true, {}, root.DragableWindow.defaults, @defaults, settings
		super(settings)
		
		
		@$countsContainer = $ "<div />"
		@$countsContainer.appendTo @$window		

		

	draw: (tape, tapeIndex) ->
		counts = {}
		for char in tape.printArray()
			counts[char] = 0 unless counts[char]? 
			counts[char]++
		@drawCounts counts
		

	drawCounts: (counts) ->
		@$countsContainer.empty()
		for char, count of counts
			unless char == " "
				$entry = $ "<p>#{char}: #{count}</p>"
				$entry.css "color", @getColorForChar char
				@$countsContainer.append $entry

					
	getColorForChar: (char) ->
		@settings.colorSettings.colorMappings[char] ? @settings.colorSettings.colorMappings.fallback
		
	
	


