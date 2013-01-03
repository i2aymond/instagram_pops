#= require test_helper

describe 'PictureView', ->

  it 'should add itself to its container given a Picture model', ->
    myPicture = new $.Picture id: 1

    assert.equal 0, $('#konacha').find('.picture_cell').length
    myPictureView = new $.PictureView
      el: $('#konacha')
      model: myPicture

    # verify the count has changed
    assert.equal 1, $('#konacha').find('.picture_cell').length

  it 'should create a picture once its model is refreshed', ->
    myPicture = new $.Picture id: 1

    myPictureView = new $.PictureView
      el: $('#konacha')
      model: myPicture

    # verify the count has changed
    assert.equal 1, $('#konacha').find('.picture_cell').length

    findPicture = (num) ->
      assert.equal num, $('#konacha').find('.picture_cell').find('.picture_container').length

    # verify there is no picture
    findPicture 0

    myPicture.trigger('change')
    image = new Image();
    image.src = myPicture.get 'low_resolution_url'
    image.onload = ->
      # verify there is a picture now
      findPicture 1
