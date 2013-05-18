class App.PlacesController extends Batman.Controller
  routingKey: 'places'

  @accessor 'activePlace', -> @places.toArray()[@get('index')]

  index: -> 
    @places = App.Place.get('all')

    @set 'index', 0

  newPlace: (form)->
    input = $(form).find('input')

    if not input.val() 
      return false

    place = App.Place.createFromName(input.val())

    if place
      place.save()
      
      place.refreshWeather()
      
      
      # Set index to last place
      @set 'index', @places.get('length') - 1 

      # Clear form
      input.val('')

  removePlace: ->
    @get('activePlace').destroy()
    @set 'index', 0

  nextPlace: ->
    if @get('index') < @places.get('length') - 1
      @set 'index', @get('index') + 1

  prevPlace: ->
    if @get('index') > 0
      @set 'index', @get('index') - 1

  refreshPlace: ->
    @get('activePlace').refreshWeather()


  ### HELPERS ###


