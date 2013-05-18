class App.Place extends Batman.Model
  @resourceName: "place"
  @persist Batman.LocalStorage

  @encode 'city', 'cords', 'weather', 'updated'

  @createFromName: (name)-> 
    place = false

    $.ajax
      type: "GET"
      url: "http://maps.googleapis.com/maps/api/geocode/json"
      data:
        address: name
        sensor: false
      dataType: "json"
      async: false
      success: (data)=>
        if (data.results[0])
          address = data.results[0].address_components
          place = new Place
            city: data.results[0].formatted_address
            cords: data.results[0].geometry.location
      error: ->
        alert 'Błąd połączenia'

    place

  @accessor 'currentTemp', -> Math.round @get('weather.currently.temperature')
  
  @accessor 'lastUpdate', -> 
    if @get('updated')
      moment.unix(@get('updated')).format('HH:mm DD/MM')

  ### Instance ###

  refreshWeather: ->
    $.getJSON "https://api.forecast.io/forecast/#{App.FORECAST_API_KEY}/#{@get('cords.lat')},#{@get('cords.lng')}?units=si&callback=?", (data)=>
      @set 'updated', moment().unix()
      @set 'weather', data
      @save()








