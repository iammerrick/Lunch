define ['models/Model', 'jquery', 'use!underscore', 'moment'], (Model, $, _, moment) ->
  class Place extends Model

    vetoesKey: 'vetoesToday'

    initialize: ->
      @setTodaysVetoes() if @has('vetoes')
      @on('change:vetoes', @setTodaysVetoes, this)

    veto: ->
      $.ajax(
        url: '/places/veto/'+@get('id')
        success: =>
          @set @vetoesKey, @get(@vetoesKey) + 1
      )

    setTodaysVetoes: ->
      today = moment().sod().valueOf()
      todaysVetoes = _.reduce @get('vetoes'), (memo, veto) ->
        if moment(veto.created).valueOf() > today
          memo + 1
        else
          memo
      , 0
      @set @vetoesKey, todaysVetoes or= 0
