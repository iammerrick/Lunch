define ['use!handlebars', 'use!underscore', 'messages/dictionary'], (Handlebars, _, dictionary) ->
  (options) ->
    settings = _.defaults options,
      helpers:
        link: (text, url) ->
          text = Handlebars.Utils.escapeExpression(text)
          url = Handlebars.Utils.escapeExpression(url)

          result = '<a href="' + url + '">' + text + '</a>'

          new Handlebars.SafeString(result)

        message: (key) ->
          dictionary.find key

    for key, helper of settings.helpers
      Handlebars.registerHelper key, helper

    Handlebars.compile(options.template)
