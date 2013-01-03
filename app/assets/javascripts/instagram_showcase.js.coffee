$ ->
  # we want to make this part of the javascript code page specific
  return if !$('body').hasClass('instagram_pops_showcase')

  # First create an album
  myAlbum = new $.Album()

  # Then create its view
  albumView = new $.AlbumView collection: myAlbum, el: $('.center_content')

  # Now adding pictures into album (the views will be created as pictures are added)
  for i in [0..11]
    myAlbum.add (new $.Picture id: i)

  # Refresh goes through every picture in album and fetches again, which causes each view to render onchange
  refresh = ->
    # show the loading image
    loading_img = $('.loading img')
    loading_img.show()

    # re-fetch all pictures again
    for i in [0..11]
      picture = myAlbum.get i
      picture.fetch
        error: (model, xhr, options) ->
          # if there is an error, just try one more time
          model.fetch error: -> # do nothing here

    # hide the loading image
    loading_img.hide()

  # Finally, refresh every 30 seconds
  refresh()
  setInterval refresh, 30000
