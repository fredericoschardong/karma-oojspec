require 'script!./oojspec/vendor/assets/javascripts/buster/lodash.js'
require 'script!./oojspec/vendor/assets/javascripts/buster/samsam.js'
require 'script!./oojspec/vendor/assets/javascripts/buster/buster-core.js'
require 'script!./oojspec/vendor/assets/javascripts/buster/buster-event-emitter.js'
require 'script!./oojspec/vendor/assets/javascripts/buster/bane.js'
require 'script!./oojspec/vendor/assets/javascripts/buster/expect.js'
require 'script!./oojspec/vendor/assets/javascripts/buster/formatio.js'
require 'script!./oojspec/vendor/assets/javascripts/buster/html.js'
require 'script!./oojspec/vendor/assets/javascripts/buster/referee.js'
require 'script!./oojspec/vendor/assets/javascripts/buster/stack-filter.js'
require 'script!./oojspec/lib/assets/javascripts/oojspec.js.coffee'
require 'script!./oojspec/lib/assets/javascripts/oojspec/utils.js.coffee'
require 'script!./oojspec/lib/assets/javascripts/oojspec/runner.js.coffee'
require 'script!./oojspec/lib/assets/javascripts/oojspec/progress.js.coffee'
require 'script!./oojspec/lib/assets/javascripts/oojspec/iframe-runner.js.coffee'
require './oojspec/lib/assets/stylesheets/oojspec/progress.css'
require './oojspec/external/busterjs/reports/resources/buster-test.css'

new class OojspecInitializer
  constructor: (@eh = oojspec.events, @karma = window.__karma__) ->
    @total = @count = 0
    @_currentStack = []
    @eh.on 'context:start', (ev) => @_currentStack.push ev.name
    @eh.on 'context:end', (ev) => @_currentStack.pop()

    @eh.on 'oojspec:examples:add', (count) => @total += count
    @eh.on 'suite:start',   => @karma.info total: @total
    @eh.on 'suite:end',     @karma.complete
    @eh.on 'test:success',  @_karmaSuccess
    @eh.on 'test:deferred', @_karmaPending
    @eh.on 'test:failure',  @_karmaFail
    @eh.on 'test:error',    @_karmaError
    @eh.on 'test:timeout',  @_karmaTimeout

    oojspec.exposeAll()
    @karma.start = -> oojspec.autorun()

  _karmaSuccess: (test) =>
    @_success test

  _success: (test, options) ->
    @karma.result @_options options,
      success: true
      description: test.name

  _options: (moreOptions, options) ->
    return options unless moreOptions
    opts = {}
    opts[k] = v for k, v of o for o in [options, moreOptions]
    opts

  _karmaPending: (test) => @_success test, skipped: true

  _karmaFail: (err) => @_error err, '[failure]'

  _karmaError: (err) => @_error err, '[error]'

  _karmaTimeout: (err) => @_error err, '[timed out]'

  _error: (err, reason) ->
    log = [reason, err.error.message]
    if err.error.stack
      log.push err.error.stack
    @karma.result
      success: false
      description: err.name
      suite: @_currentStack
      log: log
