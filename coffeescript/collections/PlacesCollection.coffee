define ['collections/Collection', 'models/Place', 'jquery', 'moment'], (Collection, Place, $, moment) ->
  class PlacesCollection extends Collection

    model: Place

    url: '/places'

    select: () ->
      $.ajax (
        url : '/places/select'
      )
