require('../oojspec.initializer.js.coffee')

describe 'Some description', ->
  @example 'async examples work 3', ->
    a = false
    setTimeout (-> a = true), 200
    @waitsFor -> a
    @runs -> @assert true

  @example 'async examples work 4', ->
    a = false
    setTimeout (-> a = true), 200
    @waitsFor -> a
    @runs -> @assert true
