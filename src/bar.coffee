class YB.Bar
  constructor: (ctx, vertical = false) ->
    @_hotSpots = []
    @_ctx = ctx
    @_vertical = vertical

  addHotSpot: (offset, degree, color) ->
    hotSpot =
      offset: offset
      degree: degree
      color: color

    @_hotSpots.push hotSpot

    @_drawHotSpot hotSpot

  getElement: -> @_ctx.canvas

  _drawHotSpot: (hotSpot) ->
    if @_vertical
      center = Math.floor (@_ctx.canvas.width / 2)
      distance = @_ctx.canvas.height
      gradient = @_ctx.createRadialGradient center, (distance * hotSpot.offset), 0, center, (distance * hotSpot.offset), (distance * hotSpot.degree)
    else
      center = Math.floor (@_ctx.canvas.height / 2)
      distance = @_ctx.canvas.width
      gradient = @_ctx.createRadialGradient (distance * hotSpot.offset), center, 0, (distance * hotSpot.offset), center, (distance * hotSpot.degree)

    gradient.addColorStop 0.0, hotSpot.color
    gradient.addColorStop 1.0, 'rgba(255, 255, 255, 0)'
    @_ctx.fillStyle = gradient

    @_ctx.fillRect 0, 0, @_ctx.canvas.width, @_ctx.canvas.height

