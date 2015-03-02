class YB.CalendarView
  barWidth = 780
  barHeight = 24

  constructor: () ->
    @taskViews = {}

    @taskTemplate = $(YB.Templates.task)
    @dateTemplate = $(YB.Templates.date)
    @element = $(YB.Templates.calendar)

    @taskList = @element.find '.yb-calendar-task-list'

    @effectDispatcher = new YB.EffectDispatcher()
    @effectDispatcher.start(0.5)

  setDateScope: (@startDate, @range) ->
    Object.keys(@taskViews).forEach(@removeTaskView.bind(@))

    date = new Date @startDate.getTime()
    dateTable = @element.find '.yb-calendar-date-table'
    cells = dateTable.children().remove()

    # update year and month
    @element.find('.yb-calendar-year').text(date.getFullYear())
    @element.find('.yb-calendar-month').text(date.getMonth() + 1)

    # update the view that shows date
    # append an additional cell to have the tail space
    for i in [0..@range]
      if !cells[i]
        cells = cells.add @_createDateCell()

      @_updateDateCell $(cells[i]), date
      date.setDate (date.getDate() + 1)

    for i in [0..cells.length - @range + 1]
      $(cells[i]).remove()

    dateTable.append cells

  createTaskView: (task) ->
    taskView = new YB.TaskView @taskTemplate.clone()[0], task, @startDate, @range + 1 # +1 to calculate tail space
    taskView.setBarSize barWidth, barHeight

    @taskViews[task.id] = taskView
    @taskList.append taskView.element

    @effectDispatcher.addEffect taskView.barEffect

    return taskView

  removeTaskView: (taskId) ->
    taskView = @taskViews[taskId]
    taskView.element.parentNode.removeChild taskView.element
    @taskViews[taskId] = null

  _createDateCell: (date) -> @dateTemplate.clone()

  _updateDateCell: (cell, date) ->
    cell.find('.yb-calendar-day').text @_translateDay(date.getDay())
    cell.find('.yb-calendar-date').text date.getDate()

  _translateDay: (day) ->
    dictionary = {
      0: 'SUN',
      1: 'MON',
      2: 'TUE',
      3: 'WED',
      4: 'THE',
      5: 'FRI',
      6: 'SAT'
    };
    return dictionary[day]
