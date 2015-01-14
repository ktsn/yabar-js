class YB.Effect
  EFFECT_WIDTH = 100

  constructor: (ctx, vertical, preprocessor) ->
    @_ctx = ctx
    @_vertical = false

    if typeof vertical == 'boolean'
      @_vertical = vertical
    else if typeof vertical == 'function'
      preprocessor = vertical

    if typeof preprocessor == 'function'
      @setPreprocessor preprocessor

  setPreprocessor: (preprocessor) ->
    @_preprocessor = preprocessor

  render: (durationRate) ->
    @_preprocessor @_ctx

    if @_vertical
      distance = @_ctx.canvas.height + EFFECT_WIDTH
      gradient = @_ctx.createLinearGradient 0, ((1 - durationRate) * distance - EFFECT_WIDTH),
                                            0, ((1 - durationRate) * distance)
    else
      distance = @_ctx.canvas.width + EFFECT_WIDTH
      gradient = @_ctx.createLinearGradient ((1 - durationRate) * distance - EFFECT_WIDTH), 0,
                                            ((1 - durationRate) * distance), 0

    gradient.addColorStop 0.0, 'rgba(255, 255, 255, 0.0)'
    gradient.addColorStop 0.5, 'rgba(255, 255, 255, 0.3)'
    gradient.addColorStop 1.0, 'rgba(255, 255, 255, 0.0)'
    @_ctx.fillStyle = gradient

    @_ctx.fillRect 0, 0, @_ctx.canvas.width, @_ctx.canvas.height

  _preprocessor: (ctx) ->
    ctx.clearRect 0, 0, ctx.canvas.width, ctx.canvas.height
