define ['i18n!messages/nls/greetings'], (greetings) ->
  dictionary =
    greetings: greetings

  find:
    (key) ->
      tree = dictionary
      split = key.split('.')
      last = split.pop()

      tree = tree[next] while next = split.shift()

      tree[last]
