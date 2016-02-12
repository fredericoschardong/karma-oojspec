describe 'Some description', ->
  @context 'inner context', ->
    @example 'this raises an error', -> nonExistent()

  @example 'async examples fails', ->
    a = false
    setTimeout (-> a = true), 200
    @waitsFor -> a
    @runs -> @assert false, 'failed for some reason'

  @example 'async examples works', ->
    a = false
    setTimeout (-> a = true), 200
    @waitsFor -> a
    @runs -> @assert true

  @example 'async examples times out', ->
    @waitsFor -> false
