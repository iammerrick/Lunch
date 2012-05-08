# Lunch

Lunch is a playground application for me to experiment with writing robust client code in CoffeeScript.

# Check This Action!

## CoffeeScript, SCSS, Compass & Require.js
First thing you will notice is I'm still using AMD for the module layer, some of the most beautiful JavaScript I've seen is this combination of tools. So to work on this application you will need to compile your CoffeeScript files like so:

`coffee -o public/javascripts/ -w coffeescript/`

And when you are ready to deploy, use r.js to build all those modules to one file:

`r.js -o config/build.js`

To compile those stylesheets:

`cd config && compass watch`

## Require.js
I am using the i18n AMD plugin for messaging and internationalization support which I tie into a Handlebars.js helper. See coffeescript/messages/dictionary.coffee and coffeescript/views/view.coffee.

## Backbone.js

You will now notice I am doing something a bit different from the conventional Backbone.js application, the views are simply relegated to returning a string and receiving a context.

I am changing Backbone.View to Controller in coffeescript/controllers/controller.coffee and adding some helpful methods like `html` & `append`, when you use @html you are able to add shortcuts in a hash like so:

{
   'name' : '.name'
}

This allows you to reference the jQuery element of `.name` as @name. 

A lot the stuff I've done here is pulled from the awesome Spine.js.


