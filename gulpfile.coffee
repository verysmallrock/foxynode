gulp = require 'gulp'
stylus = require 'gulp-stylus'
coffee = require 'gulp-coffee2'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
nodemon = require 'gulp-nodemon'
livereload = require 'gulp-livereload'

paths =
  scripts: ['client/js/**/*.coffee']
  css: ['client/css/**/*.styl']

gulp.task 'clean', (cb) ->
  del ['build'], cb

gulp.task 'build-css', ->
    gulp.src paths.css
      .pipe stylus()
      .pipe concat('application.css')
      .pipe gulp.dest('build')
      .pipe livereload()

gulp.task 'build-script', ->
  gulp.src paths.scripts
    .pipe coffee()
    .pipe concat('application.js')
    .pipe gulp.dest('build')

gulp.task 'watch',->
  livereload.listen()
  gulp.watch paths.scripts, ['build-script']
  gulp.watch paths.css, ['build-css']

gulp.task 'build', ['build-script', 'build-css']

gulp.task 'start',->
  nodemon(
    script: 'index.coffee'
    ext: 'html js coffee'
    env:
      'NODE_ENV': 'development'
  ).on('restart', ->
    console.log('restarted!')
  )

gulp.task 'default', ['watch', 'build-script', 'build-css', 'start']
