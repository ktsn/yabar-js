var del = require('del');
var gulp = require('gulp');
var coffee = require('gulp-coffee');
var sass = require('gulp-sass');
var uglify = require('gulp-uglifyjs');

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

gulp.task('coffee', ['clean'], function() {
  return gulp.src(['src/**/*.coffee'])
    .pipe(coffee().on('error', function(err) { throw err }))
    .pipe(gulp.dest('build/js/'));
});

gulp.task('build', ['sass', 'coffee']);

gulp.task('default', ['compress']);
