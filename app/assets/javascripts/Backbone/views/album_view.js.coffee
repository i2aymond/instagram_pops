$.AlbumView = Backbone.View.extend
  # there is no events: for now, only when dealing with the entire album like sorting

  initialize: ->
    _.bindAll @, 'add'
    @collection.bind 'add', @add

  # The add function is binded to this.collection.add,
  # therefore when picture models are added into collection,
  # views for these pictures are also created
  add: (m)->
    pictureView = new $.PictureView model: m, el: @el
    pictureView.render()
