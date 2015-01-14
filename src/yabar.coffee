class YB
  define: (namespace) ->
    split = namespace.split '.'

    target = @
    split.forEach (name) =>
      target[name] = {} unless target[name]?

      if typeof target != 'object'
        prefix = (namespace.split name)[0]
        throw new Error ('invalid namespace: ' + prefix + name + ' cannot be extended')

      target = target[name]

    return target

window.YB = new YB()
