define ['views/View'], (View) ->
  View
    template: """
      {{name}}
      <a href="#" class="vote">Vote <span class="bold">{{votesToday}}</span></a>
    """
