var gulp        = require('gulp'); // core gulp
var premailer   = require('gulp-premailer'); // inline CSS for HTML emails

gulp.task('premailer', function () {
  return gulp.src('./build/**/*.html')
      .pipe(premailer())
      .pipe(gulp.dest('./premailer'));
});

// Scan build directory for .html files and inline their CSS
gulp.task('default', ['premailer']);
