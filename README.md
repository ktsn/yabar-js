# yabar-js

yabar-js is the frontend module for yabar (https://github.com/13imi/yabar).

# Build

yabar-js is written as CoffeeScript code.
You should compile the source codes to execute on a browser.
You can use gulp task for the compile.

```bash
$ npm install # install npm modules
$ gulp
```

You will find the JavaScript codes in the "build/" directory.

# Structure

yabar-js has the global object named "YB".
All classes, functions and other yabar-js components should belong to the YB object.

```
YB ┬ Bar
   ├ Effect
   ├ EffectDispatcher
   ︙
```

