class YB.Bar

  constructor: (ctx, vertical = false) ->
    @_hotSpots = []
    @_ctx = ctx
    @_vertical = vertical

  # グラデーションを追加
  # offset {number} [0-1]: グラデーションの中心点．0-1 座標
  # degree {number} [0-1]: グラデーションの強さ．バーの長さ依存
  addHotSpot: (offset, degree, color, isDeadline = false) ->
    hotSpot =
      offset: offset
      degree: degree
      color: color
      isDeadline: isDeadline

    @_hotSpots.push hotSpot

    @_drawHotSpot hotSpot

  getElement: -> @_ctx.canvas

  setSize: (width, height) ->
    @_ctx.canvas.width = width
    @_ctx.canvas.height = height

    @_hotSpots.forEach(@_drawHotSpot.bind @)

  _drawHotSpot: (hotSpot) ->
    @_ctx.fillStyle = if hotSpot.isDeadline then @_createDeadlineHotSpotGradient(hotSpot) else @_createTodoHotSpotGradient(hotSpot)

    @_ctx.fillRect 0, 0, @_ctx.canvas.width, @_ctx.canvas.height

  _createTodoHotSpotGradient: (hotSpot) ->
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

    return gradient

  _createDeadlineHotSpotGradient: (hotSpot) ->
    if @_vertical
      distance = @_ctx.canvas.height
      gradient = @_ctx.createLinearGradient 0, (distance * hotSpot.offset), 0, (distance * (hotSpot.offset - hotSpot.degree))
    else
      distance = @_ctx.canvas.width
      gradient = @_ctx.createLinearGradient (distance * hotSpot.offset), 0, (distance * (hotSpot.offset - hotSpot.degree)), 0

    gradient.addColorStop 0.0, 'rgba(255, 255, 255, 0)'
    gradient.addColorStop 0.01, hotSpot.color
    gradient.addColorStop 1.0, 'rgba(255, 255, 255, 0)'

    return gradient
