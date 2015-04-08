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
