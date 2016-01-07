# Karma configuration
# Generated on Wed Jan 06 2016 17:31:46 GMT-0200 (BRST)

module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: ''


    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: []


    # list of files / patterns to load in the browser
    files: [
      'oojspec/vendor/assets/javascripts/buster/*.js'
      'oojspec/vendor/assets/stylesheets/buster/buster-test.css'
      'oojspec/lib/assets/javascripts/oojspec.js.coffee'
      'oojspec/lib/assets/javascripts/oojspec/utils.js.coffee'
      'oojspec/lib/assets/javascripts/oojspec/runner.js.coffee'
      'oojspec/lib/assets/javascripts/oojspec/progress.js.coffee'
      'oojspec/lib/assets/javascripts/oojspec/iframe-runner.js.coffee'
      'oojspec.initialize.js.coffee'
      'specs/*_spec.js.coffee'
    ]


    # list of files to exclude
    exclude: [
    ]


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      'oojspec/lib/assets/javascripts/oojspec.js.coffee': ['coffee']
      'oojspec/lib/assets/javascripts/oojspec/utils.js.coffee': ['coffee']
      'oojspec/lib/assets/javascripts/oojspec/runner.js.coffee': ['coffee']
      'oojspec/lib/assets/javascripts/oojspec/progress.js.coffee': ['coffee']
      'oojspec/lib/assets/javascripts/oojspec/iframe-runner.js.coffee': ['coffee']
      'oojspec.initialize.js.coffee': ['coffee']
      'specs/*_spec.js.coffee': ['coffee']
    }


    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress']


    # web server port
    port: 9876


    # enable / disable colors in the output (reporters and logs)
    colors: true


    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_INFO


    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true


    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome']#, 'Firefox']#, 'IE']


    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false

    # Concurrency level
    # how many browser should be started simultaneous
    concurrency: Infinity

    plugins: [
      'karma-coffee-preprocessor'
      'karma-chrome-launcher'
      'karma-firefox-launcher'
      #'karma-ie-launcher'
    ]
