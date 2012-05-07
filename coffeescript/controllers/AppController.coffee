define [
  'controllers/Controller'
  'views/AppView'
  'controllers/PlacesController'
], (Controller, AppView, PlacesController) ->
  class AppController extends Controller

    className: 'app-container'

    events:
      'click .find-out-button': 'findLocation'

    initialize: ->
      @placesController = new PlacesController
      @append AppView()
      @append @placesController

    findLocation: ->
      alert @placesController.findLocation().get('name')
