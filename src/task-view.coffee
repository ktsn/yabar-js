class YB.TaskView
  TODO_DEGREE_SEED = 0.5

  HOT_SPOT_COLOR = 'rgba(0, 150, 188, 0.8)'
  _substituteDate = (a, b) ->
    return ~~((a.getTime() - b.getTime()) / 86400000) # 24 * 60 * 60 * 1000

  constructor: (@element, @task, @startDate, @rangeDate) ->
    @barGradient = new YB.Bar @element.find('.yb-task-bar-gradient')[0].getContext('2d')
    @barEffect = new YB.Effect @element.find('.yb-task-bar-effect')[0].getContext('2d')

    @element.find('.yb-task-name').text(@task.name)

    deadlineOffset = (_substituteDate(new Date(@task.deadline), @startDate) + 1) / @rangeDate
    @barGradient.addHotSpot deadlineOffset, @task.duration / @rangeDate, HOT_SPOT_COLOR, true

  setBarSize: (width, height) ->
    barWrapper = @element.find '.yb-task-bar'
    barWrapper.width(width);
    barWrapper.height(height);

    @barGradient.setSize width, height
    @barEffect.setSize width, height

  addTodo: (todoDate) ->
    todoOffset = (_substituteDate(todoDate, @startDate) + 1) / @rangeDate
    @barGradient.addHotSpot todoOffset, @_calcTodoDegree(@task), HOT_SPOT_COLOR

  _calcTodoDegree: (task) -> parseInt(task.yabasa) * TODO_DEGREE_SEED / @rangeDate
