define [
  'controllers/Controller'
  'views/AppView'
  'controllers/PlacesController'
  'lib/io'
  'use!ui'
], (Controller, AppView, PlacesController, io, ui) ->
  class AppController extends Controller

    className: 'app-container'

    events:
      'click .find-out-button': 'findLocation'

    initialize: ->
      @placesController = new PlacesController
      @append AppView()
      @append @placesController

      io.on 'select', (place) =>
         ui.dialog(place.name)
          .closable()
          .overlay()
          .show()

    findLocation: ->
      @placesController.findLocation()
