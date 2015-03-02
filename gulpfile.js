var del = require('del');
var gulp = require('gulp');
var coffee = require('gulp-coffee');
var sass = require('gulp-sass');
var uglify = require('gulp-uglifyjs');
var inject = require('gulp-inject');
var watch = require('gulp-watch');

gulp.task('clean', function(cb) {
  del(['build'], cb);
});

gulp.task('compress', ['build'], function() {
  gulp.src(['build/js/yabar.js', 'build/js/**/*.js'])
    .pipe(uglify('yabar.min.js'))
    .pipe(gulp.dest('build/min/'));
});

gulp.task('sass', ['clean'], function() {
  return gulp.src(['sass/**/*.sass'])
    .pipe(sass({ indentedSyntax: true }))
    .pipe(gulp.dest('build/css/'));
});

gulp.task('coffee', ['template'], function() {
  return gulp.src(['build/coffee/yabar.coffee', 'build/coffee/**/*.coffee'])
    .pipe(coffee().on('error', function(err) { throw err }))
    .pipe(gulp.dest('build/js/'));
});

gulp.task('coffee-copy', ['clean'], function() {
  return gulp.src('src/**/*.coffee')
    .pipe(gulp.dest('build/coffee/'));
});

gulp.task('template', ['coffee-copy'], function() {
  return gulp.src(['src/template.coffee'])
    .pipe(inject(gulp.src(['templates/**/*.html']), {
      starttag: '# inject:{{ext}}',
      endtag: '# endinject',
      transform: function(filePath, file, i, length) {
        return 'YB.Templates.' + filePath.split('/').pop().split('.')[0] + ' = ' + '\'\'\'' + file.contents.toString('utf8') + '\'\'\'';
      }
    }))
    .pipe(gulp.dest('build/coffee/'));
});

gulp.task('watch', function() {
  watch(['src/**/*.coffee', 'sass/**/*.sass'], function() {
    gulp.start('build');
  });
});

gulp.task('build', ['sass', 'coffee']);

gulp.task('default', ['compress']);
