$ = jQuery
pluginName = "draggableWindow"

methods = 
	init: (options) ->
		defaults = 
			xOffset: 0
			yOffset: 0
		settings = $.extend defaults, options
		$this = $ this
		$this.data pluginName, settings
		$this.css "z-index", 2000
		$this.draggable()
		$this.addClass pluginName
		$this.css "left", settings.xOffset
		$this.css "top", settings.yOffset
		$this.on "mousedown", ->
			$("."+pluginName).css "z-index", 1900
			$(@).css "z-index", 2000	

 
$.fn.draggableWindow = (method) ->
  # Method calling logic
  if methods[method]
    return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ))
  else if ( typeof method == 'object' || ! method ) 
    return methods.init.apply( this, arguments )
  else
    $.error( 'Method ' +  method + ' does not exist on '+pluginName+'.tooltip' )
