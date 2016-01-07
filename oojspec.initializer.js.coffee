new class OojspecInitializer
  constructor: (@eh = oojspec.events, @karma = window.__karma__) ->
    @total = @count = 0

    @eh.on 'oojspec:examples:add', (count) => @total += count
    @eh.on 'suite:start', => @karma.info total: @total
    @eh.on 'suite:end', => @karma.complete()
    @eh.on 'test:success',  @_karmaSuccess
    @eh.on 'test:deferred', @_karmaSuccess
    @eh.on 'test:failure',  @_karmaFail
    @eh.on 'test:error',    @_karmaFail
    @eh.on 'test:timeout',  @_karmaFail

    oojspec.exposeAll()
    @karma.start = -> oojspec.autorun()

  _karmaSuccess: (test) =>
    @karma.result
      success: true
      description: test.name

  _karmaFail: (err) =>
    @karma.result
      success: false
      suite: []
      log: [err.error.name] #unfortunately we don't get a good error message from buster's event handler
