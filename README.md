# yabar-js

yabar-js is the frontend module for yabar (https://github.com/13imi/yabar).

# Requirements

- jQuery (http://jquery.com)

# Build

yabar-js is written as CoffeeScript and Sass code.
You should compile the source codes to execute on a browser.
You can use gulp task for the compile.

```bash
$ npm install # install npm modules
$ gulp
```

You will find the JavaScript and CSS files in the "build/" directory.

## Using CoffeeScript files

You have to inject html template files (in `/template`) into source codes
if you use CoffeeScript files directory.
The injected source files will be in `/build/coffee` directory after you execute `gulp` command.

# Usage

Create a CalendarView object and append its DOM element.
CalendarView constructor receives two arguments.
- 1st argument should date object that indicates the start date of the calendar.
- 2nd argument should integer that indicates the range of displaying dates.

If you want to change the calendar configuration, use `setDateScope` method.

```JavaScript
var calendar = new YB.CalendarView(new Date('2015-03-05'), 7);
$(document.body).append(calendar.element);

// change the calendar configuration
calendar.setDateScope(new Date('2015-03-12', 14));
```

You can add tasks on the calendar by using `createTaskView` method.

```JavaScript
var task = calendar.createTaskView({
  id: 1,
  created_at: "2015-01-21 02:47:20 UTC",
  name: "Task 1",
  deadline: "2015-03-21",
  yabasa: 3,
  memo: "Task memo",
  user_id: 1,
  duration: 8
});
task.addTodo(new Date('2015-03-15'));
```

# Structure

yabar-js has the global object named "YB".
All classes, functions and other yabar-js components should belong to the YB object.

```
YB ┬ Bar
   ├ Effect
   ├ EffectDispatcher
   ︙
```
