define ['models/Model', 'jquery', 'use!underscore', 'moment'], (Model, $, _, moment) ->
  class Place extends Model

    votesKey: 'votesToday'

    initialize: ->
      @setTodaysVotes() if @has('votes')
      @on('change:votes', @setTodaysVotes, this)

    idAttribute: '_id'

    vote: ->
      $.ajax(
        url: '/places/vote/'+@get('_id')
        success: =>
          @set @votesKey, @get(@votesKey) + 1
      )

    setTodaysVotes: ->
      today = moment().sod().valueOf()
      todaysVotes = _.reduce @get('votes'), (memo, vote) ->
        if moment(vote.created).valueOf() > today
          memo + 1
        else
          memo
      , 0
      @set @votesKey, todaysVotes or= 0
