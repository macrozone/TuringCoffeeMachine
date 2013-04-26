
root = exports ? this


root.ColorMappingWindow = class extends root.DragableWindow
	
	
	constructor: (@mapping, windowSettings) ->
		defaults = 
			title: "Colors"
		super $.extend true, {}, defaults, windowSettings
		
		for char, color of @mapping
			
			$element = $ "<span>"+char+" </span>"
			$element.css "color", color
			@$content.append $element
		