require.config
  paths:
    'jquery': 'vendor/jquery-1.7.2'
    'backbone': 'vendor/backbone'
    'underscore': 'vendor/underscore'
    'handlebars': 'vendor/handlebars-1.0.0.beta.6'
    'text': 'vendor/require.text'
    'i18n': 'vendor/i18n'
    'use': 'vendor/use'
  use:
    'underscore':
      attach: '_'

    'backbone':
      deps: ['use!underscore', 'jquery']
      attach: (_, $) ->
        Backbone

    'vendor/keymaster':
      attach: 'key'

    'handlebars':
      attach: 'Handlebars'

require ['jquery', 'controllers/app'], ($, App) ->
  new App({el : document.body}).render()

