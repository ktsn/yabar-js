class YB.Effect
  EFFECT_WIDTH = 100

  # ctx {CanvasRenderingContext2D}: エフェクトを描画する Canvas コンテキスト
  # [vertical] {boolean}: エフェクトの方向が縦かどうか
  # [preprocessor] {function}: エフェクトの描画の前に行う処理
  constructor: (ctx, vertical, preprocessor) ->
    @_ctx = ctx
    @_vertical = false

    if typeof vertical == 'boolean'
      @_vertical = vertical
    else if typeof vertical == 'function'
      preprocessor = vertical

    if typeof preprocessor == 'function'
      @setPreprocessor preprocessor

  setSize: (width, height) ->
    @_ctx.canvas.width = width
    @_ctx.canvas.height = height

  # エフェクトを描画する前に行う処理をセット
  # preprocessor {function}
  setPreprocessor: (preprocessor) ->
    @_preprocessor = preprocessor

  # Canvas 上にエフェクトを描画
  # durationRate {number} [0-1]: エフェクトのアニメーションの進行率
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
