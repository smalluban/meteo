Batman.mixin Batman.Filters,
  temp: (temp) ->
    Math.round temp
  day: (timestamp)->
    moment.unix(timestamp).format('ddd')