class App.PlacesController extends Batman.Controller
  routingKey: 'places'

  @accessor 'activePlace', -> @places.toArray()[@get('places.active')]

  index: ->
    @places = App.Place.get('all')

    @places.forEach (p)->
      # Last update older then hour
      if moment().unix() - p.get('updated') > 60 * 60
        p.refreshWheather() 
        
    @places.set('active', 0)

  ### Events ###

  toggleForm: ->
    if @get('viewClass') == 'form'
      @set 'viewClass',  '' 
      $('*').blur() # Screen keybord hack
    else 
      @set 'viewClass', 'form'

  newPlace: (form)->
    input = $(form).find 'input[type=text]'
    oldMax = @get('places').length - 1

    # Input can not be empty
    return if not input.val()

    # Create new place
    place = App.Place.createFromAddress input.val()
    place.save()
    place.refreshWheather()

    # Clear form
    input.val('').blur()

    # Move Scroller to new place
    @set 'places.active', oldMax + 1

    # Clear viewClass
    @set 'viewClass', ''

  refresh:-> @get('activePlace')?.refreshWheather()
  remove: -> @get('activePlace')?.destroy()

