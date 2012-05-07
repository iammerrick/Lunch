define [
  'controllers/Controller'
  'views/AppView'
  'controllers/PlacesController'
  'use!ui'
], (Controller, AppView, PlacesController, ui) ->
  class AppController extends Controller

    className: 'app-container'

    events:
      'click .find-out-button': 'findLocation'

    initialize: ->
      @placesController = new PlacesController
      @append AppView()
      @append @placesController

    findLocation: ->
      ui.dialog(@placesController.findLocation().get('name'))
        .closable()
        .overlay()
        .show()
