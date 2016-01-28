require ['./oojspec/vendor/assets/javascripts/buster/all.js.coffee'
'./oojspec/vendor/assets/stylesheets/buster/buster-test.css'
'./oojspec/lib/assets/javascripts/oojspec.js.coffee'
'./oojspec/lib/assets/javascripts/oojspec/utils.js.coffee'
'./oojspec/lib/assets/javascripts/oojspec/runner.js.coffee'
'./oojspec/lib/assets/javascripts/oojspec/progress.js.coffee'
'./oojspec/lib/assets/javascripts/oojspec/iframe-runner.js.coffee'],
-> new class OojspecInitializer
  constructor: (@eh = oojspec.events, @karma = window.__karma__) ->
    @total = @count = 0
    @_currentStack = []
    @eh.on 'context:start', (ev) => @_currentStack.push ev.name
    @eh.on 'context:end', @_contextEnd

    @eh.on 'oojspec:examples:add', (count) => @total += count
    @eh.on 'suite:start',   => @karma.info total: @total
    @eh.on 'suite:end',     @karma.complete
    @eh.on 'test:success',  @_karmaSuccess
    @eh.on 'test:deferred', @_karmaPending
    @eh.on 'test:failure',  @_karmaFail
    @eh.on 'test:error',    @_karmaError
    @eh.on 'test:timeout',  @_karmaTimeout

    console.log oojspec
    window.oojspec = oojspec
    oojspec.exposeAll()
    @karma.start = -> oojspec.autorun()

  _contextEnd: (ev) =>
    @_currentStack.pop()
    #@karma.reload(true)

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
      log.push err.error.stack.replace(/[\n]?.*?oojspec\.initializer\.js.*?\n/g, "\n")
    @karma.result
      success: false
      description: err.name
      suite: @_currentStack
      log: log
