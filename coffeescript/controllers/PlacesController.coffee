define [
  'controllers/Controller'
  'collections/PlacesCollection'
  'views/PlaceItemView'
], (Controller, PlacesCollection, PlaceItemView) ->

  class PlaceItemController extends Controller

    className: 'place'

    tagName: 'li'

    events:
      'click .veto' : 'veto'

    initialize: ->
      @model.on 'change:#{@model.vetoesKey}', @render

    render: =>
      @html PlaceItemView @model.toJSON()
      this

    veto: ->
      @model.veto()

  class PlacesController extends Controller

    className: 'places list'

    tagName: 'ul'

    initialize: ->
      @collection = new PlacesCollection
      @collection.on 'reset', @render, this
      @collection.fetch()

    render: ->
      @append '<h2>What are my options?</h2>'
      @collection.each (place) =>
        @append new PlaceItemController(model: place).render()
      this

    findLocation: ->
      throw "No collection!" unless @collection

      @collection.select()
