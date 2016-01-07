describe 'Some description', ->
  @example 'async examples work', ->
    a = false
    setTimeout (-> a = true), 200
    @waitsFor -> a
    @runs -> @assert false

  @example 'async examples work 2', ->
    a = false
    setTimeout (-> a = true), 200
    @waitsFor -> a
    @runs -> @assert true
