class Collapsible
  setup: ->
    $('.collapsible-container').each (i, el) ->
      $(el).find('.collapsible-title').click -> $(el).toggleClass('collapsed')

@collapsible = new Collapsible()
