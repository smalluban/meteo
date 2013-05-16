class App.ScrollerView extends Batman.View
  offset: 15 # Percente offset to trigger slide change

  render: ->
    node = $(@get('node'))

    # Get first active
    @set 'active', @context.get('places.active')

    # When active change (in Scroller), move scroller to proper position
    @observeAndFire 'active', (newValue)->
      @context.get('places').set 'active', newValue
      @setOffset newValue

    # When active change (in Controller) move scroller to proper position
    # Set active in Scroller (will trigger change)
    @context.get('places').on 'itemsWereAdded', => 
      @set 'active', @context.get('places.length') - 1

    @context.get('places').on 'itemsWereRemoved', =>
      @set 'active', if @get('active') > 0 then @get('active') - 1 else 0

    # When window change size recalculate offset
    $(window).resize => @setOffset @get('active')

    # Set drag events
    node.drag 'start', =>
      $('*').blur()
      node.addClass('drag')

    node.drag (ev, dd)=>
      length = @context.get('places.length')

      if length == 1 or (dd.deltaX > 0 and @get('active') == 0) or (dd.deltaX < 0 and @get('active') == length - 1)
        node.removeClass('drag')
        return false

      node.css transform: "translate3d(#{dd.offsetX}px, 0px, 0px)"

    node.drag 'end', (ev,dd)=>
      node.removeClass 'drag'
      
      return false if @context.get('places.length') == 1

      if dd.deltaX > ($(window).width() / 100) * @offset
        @set 'active', @get('active') - 1
      else if dd.deltaX < - ($(window).width() / 100) * @offset
        @set 'active', @get('active') + 1
      else
        @setOffset @get('active')

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





