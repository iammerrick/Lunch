define ['controllers/controller', 'views/app'], (Controller, AppView) ->
  class App extends Controller
    initialize: ->
      @html AppView()
