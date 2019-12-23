var gulp = require('gulp');
var runSequence = require('run-sequence').use(gulp);

var eslint = require('gulp-eslint');
var uglify = require('gulp-uglify');
var concat = require('gulp-concat');
var rename = require('gulp-rename');
var jsonminify = require('gulp-jsonminify');
var cleancss = require('gulp-clean-css');

var output = './dist';
var jsfiles = './src/js/*.js';
var cssfiles = './src/css/*.css';
var data = './src/data/*.geojson';

gulp.task('lint', function() {
	gulp.src(jsfiles)
		.pipe(eslint())
		.pipe(eslint.format())
		.pipe(eslint.failAfterError());
});

gulp.task('distjs', function() {
	gulp.src(jsfiles)
		.pipe(rename({suffix: '.min'}))
		.pipe(uglify())
		.pipe(gulp.dest(output));
});

gulp.task('distcss', function() {
	gulp.src(cssfiles)
		.pipe(concat(output))
		.pipe(rename('publish.min.css'))
		.pipe(cleancss({compatibility: 'ie8'}))
		.pipe(gulp.dest(output));
});

gulp.task('minify', function() {
	gulp.src(data)
	.pipe(jsonminify())
	.pipe(gulp.dest(output + '/data'));
});

gulp.task('watch', function() {
	gulp.watch(jsfiles, function() {
		runSequence('lint');
	});
});

gulp.task('default', function() {
	runSequence('lint', 'distjs', 'distcss');
});
