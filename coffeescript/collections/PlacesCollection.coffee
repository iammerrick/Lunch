define ['collections/Collection', 'models/Place', 'moment'], (Collection, Place, moment) ->
  class PlacesCollection extends Collection

    model: Place

    url: '/places'

    comparator: (compare) ->
      Math.random()

    select: () ->
      today = moment().sod().valueOf()
      selectionPool = []

      for key, place of @models
        votes = place.get place.votesKey
        if votes > 0
          selectionPool.push(place.id) for i in [1..votes]

      @get selectionPool[Math.floor Math.random() * selectionPool.length]
