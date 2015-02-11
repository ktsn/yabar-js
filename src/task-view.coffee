class YB.TaskView
  TODO_DEGREE_SEED = 0.5

  HOT_SPOT_COLOR = 'rgba(0, 92, 255, 0.5)'
  _substituteDate = (a, b) ->
    return ~~((a.getTime() - b.getTime()) / 86400000) # 24 * 60 * 60 * 1000

  constructor: (@element, @task, @startDate, @rangeDate) ->
    @barGradient = new YB.Bar @element.querySelector('.yb-task-bar-gradient').getContext('2d')
    @barEffect = new YB.Effect @element.querySelector('.yb-task-bar-effect').getContext('2d')

    @element.querySelector('.yb-task-name').textContent = @task.name
    @element.querySelector('.yb-task-yabasa').textContent = @task.yabasa

    deadlineOffset = (_substituteDate(new Date(@task.deadline), @startDate) + 1) / @rangeDate
    @barGradient.addHotSpot deadlineOffset, @task.duration / @rangeDate, HOT_SPOT_COLOR, true

  setBarSize: (width, height) ->
    barWrapper = @element.querySelector '.yb-task-bar'
    barWrapper.style.width = width + 'px';
    barWrapper.style.height = height + 'px';

    @barGradient.setSize width, height
    @barEffect.setSize width, height

  addTodo: (todoDate) ->
    todoOffset = (_substituteDate(todoDate, @startDate) + 1) / @rangeDate
    @barGradient.addHotSpot todoOffset, @_calcTodoDegree(@task), HOT_SPOT_COLOR

  _calcTodoDegree: (task) -> parseInt(task.yabasa) * TODO_DEGREE_SEED / @rangeDate
