
root = exports ? this


root.ColorMappingWindow = class extends root.DragableWindow
	
	
	constructor: (@mapping, windowSettings) ->
		super windowSettings
		
		for char, color of @mapping
			
			$element = $ "<span>"+char+" </span>"
			$element.css "color", color
			@$window.append $element
		