class App.ScrollerView extends Batman.View
  offset: 15 # Percente offset to trigger slide change

  render: ->
    node = $(@get('node'))
    places = @context.get('places')

    # When active change move scroller to proper position
    places.observeAndFire 'active', (newValue)=> @setOffset newValue or 0

    # When window change size recalculate offset
    $(window).resize => @setOffset places.get('active')

    # Set drag events
    node.drag 'start', =>
      $('*').blur()
      node.addClass('drag')

    node.drag (ev, dd)=>
      length = places.get('length')

      if length == 1 or (dd.deltaX > 0 and places.get('active') == 0) or (dd.deltaX < 0 and places.get('active') == length - 1)
        node.removeClass('drag')
        return false

      node.css transform: "translate3d(#{dd.offsetX}px, 0px, 0px)"

    node.drag 'end', (ev,dd)=>
      node.removeClass 'drag'
      
      return false if @context.get('places.length') == 1

      if dd.deltaX > ($(window).width() / 100) * @offset
        places.set 'active', places.get('active') - 1
      else if dd.deltaX < - ($(window).width() / 100) * @offset
        places.set 'active', places.get('active') + 1
      else
        @setOffset places.get('active')

    super

  setOffset: (el)=>
    offset = if el > 0 then el else 0
    $(@get('node')).css transform: "translate3d(#{ - offset * $(window).width() }px, 0px, 0px)"

class App.ScrollerItemView extends Batman.View
  render: ->
    $(window).resize @setSize
    @setSize()
    super

  setSize: => $(@get('node')).css width: $(window).width()

  viewWillDisappear: -> $(window).unbind 'resize', @setSize





