class Collapsible
  setup: ->
    $('.collapsible-container').each (i, el) ->
      $(el).find('.collapsible-title').click -> $(el).toggleClass('collapsed')

    #FIXME this is a hack for expanding on load for migration comments
    $('.migration-comments .thread a').click()




@collapsible = new Collapsible()
