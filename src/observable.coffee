class YB.Observable

  constructor: () ->
    @_listeners = {}

  on: (name, func) ->
    @_listeners[name] = [] if !@_listeners[name]?
    @_listeners[name].push func

  off: (name, func = null) ->
    return if !@_listeners[name]?

    if typeof func == 'function'
      # remove given listener
      @_listeners[name].splice @_listeners.indexOf(func), 1
    else
      @_listeners[name] = []

  fire: (name, data = null) ->
    return if !@_listeners[name]?

    @_listeners[name].forEach (listener) ->
      setTimeout listener.bind(@, data), 0
