define ['views/View'], (View) ->
  View
    template: """
      {{name}}
      <a href="#" class="veto">Veto <span class="bold">{{vetoesToday}}</span></a>
    """
