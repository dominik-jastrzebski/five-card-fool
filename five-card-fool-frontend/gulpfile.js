const gulp = require('gulp');
const concat = require('gulp-concat');

const HubRegistry = require('gulp-hub');
const browserSync = require('browser-sync');

const conf = require('./conf/gulp.conf');

// Load some files into the registry
const hub = new HubRegistry([conf.path.tasks('*.js')]);

// Tell gulp to use the tasks just loaded
gulp.registry(hub);

gulp.task('build', gulp.series('styles', gulp.parallel('other', 'webpack:dist')));
gulp.task('test', gulp.series('karma:single-run'));
gulp.task('test:auto', gulp.series('karma:auto-run'));
gulp.task('serve', gulp.series('webpack:watch', 'watch', 'browsersync'));
gulp.task('serve:dist', gulp.series('default', 'browsersync:dist'));
gulp.task('default', gulp.series('clean', 'build'));
gulp.task('watch', watch);
gulp.task('styles', styles);

function reloadBrowserSync(cb) {
  browserSync.reload();
  cb();
}

function watch(done) {
  gulp.watch(conf.path.src('app/**/*.html'), reloadBrowserSync);
  gulp.watch([conf.path.src('app/**/*.css'), conf.path.src('app/index.css')], { ignoreInitial: false }, styles);
  done();
}

function styles(done) {
  gulp.src(['src/app/**/*.css', 'src/index.css'])
    .pipe(concat('bundle.css'))
    .pipe(gulp.dest('./src'));
  done();
}
