"use strict";

const gulp = require('gulp'),
  path = require('path'),
  fs = require('fs'),
  $ = require('gulp-load-plugins')(),
  source = require('vinyl-source-stream'),
  browserify = require('browserify'),
  watchify = require('watchify'),
  babelify = require('babelify');
    
gulp.task('scripts:server', () => {
  return gulp.src("./src-server/**/*.js")
    .pipe($.cached('server'))
    .pipe($.babel())
    .pipe(gulp.dest('./build'))
});

gulp.task('watch:scripts:server', gulp.series(
  'scripts:server', 
  () => gulp.watch('./src-server/**/*.js', gulp.series('scripts:server'))
));

gulp.task('watch:scripts:client', () => {
  fs.readdirSync('./src-client').forEach(file => {
    if (path.extname(file) === ".js") {
      initBundlerWatch(path.join('src-client', file))
    }
  })
  
  return gulp.watch('./src-client/**/*.js').on('change', initBundlerWatch)
})

gulp.task('watch:scripts', gulp.parallel(
  'watch:scripts:server',
  'watch:scripts:client'
))

let bundlers = {};
function initBundlerWatch(file) {
  if (bundlers.hasOwnProperty(file)) {
    return;
  }
  
  const bundler = createBundler(file),
    watcher = watchify(bundler),
    filename = path.basename(file);
    
  bundlers[file] = bundler;
    
  function bundle() {
    return bundler.bundle()
      .on('error', error => console.error(error))
      .pipe(source(filename))
      .pipe(gulp.dest('./public/build'));
  }
  
  watcher.on('update', bundle);
  watcher.on('time', time => console.log(`Built client in ${time}ms`))
  
  bundle();
}

function createBundler(file) {
  const bundler = browserify(file);
  bundler.transform(babelify);
  return bundler;
}