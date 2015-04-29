var gulp   = require('gulp'); // core gulp
var uncss  = require('gulp-uncss'); // removes unused css
var csso   = require('gulp-csso'); // minify css
var gzip   = require('gulp-gzip'); // gzip compression

gulp.task('uncss', function() {
  return gulp.src('build/assets/css/**/*.css')
    .pipe(uncss({
        html: ['build/**/*.html']
    }))
    .pipe(csso())
    .pipe(gulp.dest('./build/assets/css'))
    .pipe(gzip())
    .pipe(gulp.dest('./build/assets/css'));
});

// Scan site, remove unused css, minifiy css, gzip css
gulp.task('buildcss', ['uncss']);
