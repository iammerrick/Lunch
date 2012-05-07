define ['use!backbone'], ({View}) ->
  class Controller extends View
    initialize: ->
      @refreshElements()

    ###
    Sets the html of this controller and refreshes
    the element shortcuts.
    ###
    html: (html) ->
      @$el.html html
      @refreshElements()
      this

    append: (el) ->
      @$el.append(@getElement(el))

    prepend: (el) ->
      @$el.prepend(@getElement(el))
      this

    ###
    Utility method that renders and returns the element
    from a view or just returns the element if one is passed.
    ###
    getElement: (el) ->
      el?.el or el

    ###
    Takes the elements property if available and sets shortcuts
    on the view E.G.

      elements:
        name: '.name'

    you would be able to reference this.name as the element.
    ###
    refreshElements: () ->
      @[key] = @$(selector) for key, selector of @elements if @elements?
      this
