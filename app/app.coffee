# Set view prefix
getViewPrefix = ->
  if not window.location.host
    window.location.href.replace(/^[a-z]+\:\/+/,'').replace(/index\.html$/,'')
  else
    ''

# CONFIG FOR ANDROID ASSETS
Batman.config.pathToHTML = getViewPrefix() + "views"
Batman.config.usePushState = false

class App extends Batman.App
  # Set the root route to ExamplesController#index.
  @root 'example#index'

# Make App available in the global namespace so it can be used
# as a namespace and bound to in views.
window.App = App