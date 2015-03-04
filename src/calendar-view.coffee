class YB.CalendarView
  barWidth = 780
  barHeight = 24

  _equalsDate = (a, b) ->
    return a.setHours(0, 0, 0, 0) == b.setHours(0, 0, 0, 0)

  constructor: (startDate, range) ->
    @taskViews = {}

    @taskTemplate = $(YB.Templates.task)
    @dateTemplate = $(YB.Templates.date)
    @element = $(YB.Templates.calendar)

    @taskList = @element.find '.yb-calendar-task-list'

    @effectDispatcher = new YB.EffectDispatcher()
    @effectDispatcher.start(0.5)

    @setDateScope startDate, range

  setDateScope: (@startDate, @range) ->
    Object.keys(@taskViews).forEach(@removeTaskView.bind(@))

    date = new Date @startDate.getTime()
    dateTable = @element.find '.yb-calendar-date-table'
    cells = dateTable.children().remove()

    splitterTable = @element.find '.yb-calendar-splitter'
    splitters = splitterTable.children().remove()

    # update year and month
    @element.find('.yb-calendar-year').text(date.getFullYear())
    @element.find('.yb-calendar-month').text(date.getMonth() + 1)

    # update the view that shows date
    # append an additional cell to have the tail space
    # also add splitters for each date
    for i in [0..@range]
      if !cells[i]
        cells = cells.add @_createDateCell()

      if !splitters[i]
        splitters = splitters.add @_createSplitter()

      @_updateDateCell $(cells[i]), date, i
      $(cells[i]).addClass('yb-calendar-today') if _equalsDate date, new Date()

      date.setDate (date.getDate() + 1)

    # remove wasted cells and splitters
    for i in [0..cells.length - @range + 1]
      $(cells[i]).remove()
      $(splitters[i]).remove()

    dateTable.append cells
    splitterTable.append splitters

  createTaskView: (task) ->
    taskView = new YB.TaskView @taskTemplate.clone(), task, @startDate, @range + 1 # +1 to calculate tail space
    taskView.setBarSize barWidth, barHeight

    @taskViews[task.id] = taskView
    @taskList.append taskView.element

    @effectDispatcher.addEffect taskView.barEffect

    return taskView

  removeTaskView: (taskId) ->
    taskView = @taskViews[taskId]
    taskView.element.remove()
    @taskViews[taskId] = null

  _createDateCell: () -> @dateTemplate.clone()

  _updateDateCell: (cell, date, i) ->
    cell.find('.yb-calendar-day').text @_translateDay(date.getDay())

    d = date.getDate()
    # show the month if the date is the first date of the month
    if d == 1 && i > 0
      d = [date.getMonth() + 1, d].join('.')
    cell.find('.yb-calendar-date').text d

  _createSplitter: () -> $('<div class="yb-calendar-splitter-item"></div>')

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
