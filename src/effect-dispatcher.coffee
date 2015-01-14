class YB.EffectDispatcher
  requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
                           window.webkitRequestAnimationFrame || window.msRequestAnimationFrame

  constructor: ->
    @_effects = []
    @_effectRunning = false

  addEffect: (effect) ->
    @_effects.push effect

  resetEffect: ->
    @stop()
    @_effects = []

  start: (freq) ->
    @_effectRunning = true
    requestAnimationFrame (@_continueAnimation freq)

  stop: ->
    this._effectRunning = false

  _continueAnimation: (freq) ->
    startTime = null

    animate = (timestamp) =>
      startTime = timestamp unless startTime?
      duration = timestamp - startTime

      # ループのどの位置なのかを得る
      durationRate = freq * (duration / 1000)
      durationRate = parseFloat ('0.' + (durationRate.toString().split('.')[1]))

      @_effects.forEach ((effect) -> effect.render durationRate)

      requestAnimationFrame animate if @_effectRunning
