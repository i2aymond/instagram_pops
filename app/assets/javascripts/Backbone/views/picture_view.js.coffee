$.PictureView = Backbone.View.extend
  events:
    'mouseenter .picture_container': "onComment"
    'mouseleave .picture_container': "offComment"

  initialize: ->
    # create a new article, appends itself to the page, then set its element to the new article
    newDiv = $('<article/>')
    newDiv.addClass 'picture_cell'
    @$el.append newDiv
    @setElement newDiv

    _.bindAll @, 'render', 'onComment', 'offComment'
    @model.on 'change', @render

  #The render function basically takes the mustache template and redraw the div with model's JSON
  render: ->
    # we try to make sure the image is loaded first from Instagram for smooth animation
    image = new Image();
    image.src = @model.get 'low_resolution_url'
    image.onload = =>
      @$el.find('.picture_container').fadeOut 20
      @$el.html HoganTemplates['Mustache/templates/instagram_pop'].render(@model.toJSON())
      @$el.find('.picture_container').fadeIn('slow')
    @

  onComment: ->
    @$el.find('.picture_comment').show()

  offComment: ->
    @$el.find('.picture_comment').hide()

