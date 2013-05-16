# Config for android/ios assets path

# Helper function
getViewPrefix = ->
  if not window.location.host
    window.location.href.replace(/^[a-z]+\:\/+/,'').replace(/index\.html$/,'')
  else
    ''

Batman.config.pathToHTML = getViewPrefix() + "views"
Batman.config.usePushState = false


# Main app
class App extends Batman.App
  @FORECAST_API_KEY: "02ff61b9cd195f01d59986a29f31b832"

  # Set the root route
  @root 'places#index'


# Make App available in the global namespace so it can be used
# as a namespace and bound to in views.
window.App = App