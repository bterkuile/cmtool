class HtmlEdit
  setup: ->
    #ACE
    locale_field = $('#page_locale')
    $('.html-content').each (i, el)->
      text_field = $(el)
      template_field = $("##{text_field.attr('id')}_template")
      ace_div = $('<div></div>').addClass('ace-div')
      text_field.after ace_div
      ace_div.css
        width: '100%'
        height: '600px'
      editor = ace.edit(ace_div.get(0))
      editor.setTheme 'ace/theme/monokai'
      if template_field.length
        editor.setValue template_field.val(), -1
        editor.getSession().setMode 'ace/mode/haml'
        console.log "Editing haml"
      else
        editor.setValue text_field.val(), -1
        editor.getSession().setMode 'ace/mode/handlebars'
        console.log "Editing handlebars"
      editor.getSession().setTabSize(2)
      editor.getSession().setUseSoftTabs(true)
      template_vars = page_vars
      if locale = locale_field.val()
        template_vars = template_vars[locale] if template_vars[locale]
      rebuild_html = ->
        value = editor.getValue()
        if template_field.length
          try
            template = Emblem.compile(Handlebars, value)
            result_value = template(template_vars)
            template_field.val value
            text_field.val result_value
        else
          text_field.val value
      editor.getSession().on 'change', rebuild_html
      locale_field.change ->
        locale = $(this).val()
        template_vars = page_vars[locale] if page_vars[locale]
        rebuild_html()
      text_field.hide()
      template_field.hide()
@html_edit = new HtmlEdit()
Handlebars.registerHelper "link-to", (url, args..., options = {})->
  unless not url or url.match(/^http|^\/\w{2}\//)
    # Starts with http or /:locale/ explicitly
    if options.hash and options.hash.hasOwnProperty 'locale'
      if locale = options.hash.locale
        url = "/#{locale}/#{url}".replace('//', '/')
    else if locale = $('#page_locale').val()
      url = "/#{locale}/#{url}".replace('//', '/')
  if options.fn
    text = options.fn(this)
  else
    text = args[0]
  link = "<a href='#{url}'>#{text}</a>"
  new Handlebars.SafeString(link)
