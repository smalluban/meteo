class App.Place extends Batman.Model
  @resourceName: "place"
  @persist Batman.LocalStorage

  @encode 'city', 'country', 'cords', 'weather', 'updated'

  # Construct instance from address string
  # It using Google Maps Api to find cords
  @createFromAddress: (address)->
    throw 'Address can not be empty' if not address

    place = false

    $.ajax
      type: "GET"
      url: "http://maps.googleapis.com/maps/api/geocode/json"
      data: 
        address: address
        sensor: false
      dataType: "json"
      async: false
      success: (data)=>
        if (data = data.results[0])
          address = data.address_components
          place = new App.Place
            city: address[0].long_name
            country: address[address.length - 1].long_name
            cords: data.geometry.location

    place

  ### INSTANCE ###

  @accessor 'updateFormated', ->
    if @get('updated')
      moment.unix(@get('updated')).format('HH:mm DD/MM')
    else 
      false

  refreshWheather: ->
    @set 'loading', true
    $.getJSON "https://api.forecast.io/forecast/#{App.FORECAST_API_KEY}/#{@get('cords.lat')},#{@get('cords.lng')}?units=si&callback=?", (data)=>
      # Splice more than 4 daily data
      data.daily.data = data.daily.data.splice(0,4)
      console.log @set 'weather', data
      @set 'updated', moment().unix()
      @set 'loading', false
      @save()

