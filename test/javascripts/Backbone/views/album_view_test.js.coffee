#= require test_helper

describe 'AlbumView', ->

  it 'should add a view to page when a picture is added', ->
    myAlbum = new $.Album()

    myAlbumView = new $.AlbumView
      collection: myAlbum
      el: $('#konacha')

    assert.equal 0, $('#konacha').find('.picture_cell').length
    myAlbum.add (new $.Picture id: 1)
    # verify the content changed
    assert.equal 1, $('#konacha').find('.picture_cell').length
