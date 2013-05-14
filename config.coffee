exports.config =
  # See http://brunch.io/#documentation for docs.
  paths:
    public: 'android/assets/www/'

  modules:
    definition: false
    wrapper: false

  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^vendor/
        'test/js/test.js': /^test[\\/](?!vendor)/
        'test/js/test-vendor.js': /^test[\\/](?=vendor)/
      order:
        # Files in `vendor` directories are compiled before other files
        # even if they aren't specified in order.before.
        before: [
          'vendor/scripts/console-polyfill.js',
          'vendor/scripts/jquery-1.9.1.js',
          'vendor/scripts/batman.jquery-0.14.1.js'
          'app/app.coffee'
        ]
        after: [
          'test/vendor/scripts/test-helper.js'
        ]

    stylesheets:
      joinTo:
        'css/app.css': /^(app|vendor)/
        'test/css/test.css': /^test/
      order:
        after: ['vendor/styles/helpers.css']

    templates:
      joinTo: 'js/dontUseMe' : /^app/ # dirty hack for Jade compiling.

  plugins:
    jade:
      options:       
        pretty: yes    
    # static_jade:
    #  asset: "app/assets/html/"
    #  path:       [ /app(\/|\\)docs/ ]  # static-compile each file in this directories                   
    #   extension:  ".static.jade"        # static-compile each file with this extension in `assets`
    
      
