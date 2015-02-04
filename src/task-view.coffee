class YB.TaskView
  TODO_HOT_SPOT_DEGREE = 2
  DEADLINE_HOT_SPOT_DEGREE = 7
  HOT_SPOT_COLOR = 'rgba(255, 0, 0, 0.7)'
  _substituteDate = (a, b) ->
    return ~~((a.getTime() - b.getTime()) / 86400000) # 24 * 60 * 60 * 1000

  constructor: (@element, @task, @startDate, @rangeDate) ->
    @barGradient = new YB.Bar @element.querySelector('.yb-task-bar-gradient').getContext('2d')
    @barEffect = new YB.Effect @element.querySelector('.yb-task-bar-effect').getContext('2d')

    @element.querySelector('.yb-task-name').textContent = @task.name
    @element.querySelector('.yb-task-yabasa').textContent = @task.yabasa

    deadlineOffset = (_substituteDate(new Date(@task.deadline), @startDate) + 1) / @rangeDate
    @barGradient.addHotSpot deadlineOffset, DEADLINE_HOT_SPOT_DEGREE / @rangeDate, HOT_SPOT_COLOR, true

  setBarSize: (width, height) ->
    barWrapper = @element.querySelector '.yb-task-bar'
    barWrapper.style.width = width + 'px';
    barWrapper.style.height = height + 'px';

    @barGradient.setSize width, height
    @barEffect.setSize width, height

  addTodo: (todoDate) ->
    todoOffset = (_substituteDate(todoDate, @startDate) + 1) / @rangeDate
    @barGradient.addHotSpot todoOffset, TODO_HOT_SPOT_DEGREE / @rangeDate, HOT_SPOT_COLOR
