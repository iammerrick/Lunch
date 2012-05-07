define ['i18n!messages/nls/messages'], (messages) ->
  dictionary =
    messages: messages

  find:
    (key) ->
      tree = dictionary
      split = key.split('.')
      last = split.pop()

      tree = tree[next] while next = split.shift()

      tree[last]
