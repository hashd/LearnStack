var gulp = require('gulp'),
	browserify = require('browserify'),
	babelify = require('babelify'),
	source = require('vinyl-source-stream'),
	uglify = require('gulp-uglify'),
	concat = require('gulp-concat');

gulp.task('build', function () {
	browserify({
		entries: 'app.js',
		extensions: ['.jsx'],
		debug: true
	})
	.transform(babelify)
	.bundle()
	.pipe(source('bundle.js'))
	.pipe(gulp.dest('dist'));
});

gulp.task('build:minify', function () {
	gulp.src('dist/bundle.js')
		.pipe(concat('bundle.min.js'))
		.pipe(uglify())
		.pipe(gulp.dest('dist'))
})

gulp.task('default', ['build', 'build:minify']);