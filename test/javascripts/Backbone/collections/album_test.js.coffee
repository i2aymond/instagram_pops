#= require test_helper

describe 'Album', ->
  it 'should have picture as its model', ->
    album = new $.Album()
    album.add (new $.Picture id: 1)
    assert.ok album.get(1)
