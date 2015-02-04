class YB.TaskViewFactory
  constructor: (template) ->
    @template = template
    @effectDispatcher = new YB.EffectDispatcher()
    @effectDispatcher.start(1)

  createTaskView: (task, startDate, rangeDate) ->
    task = new YB.TaskView @template.cloneNode(true), task, startDate, rangeDate
    @effectDispatcher.addEffect task.barEffect
    return task

