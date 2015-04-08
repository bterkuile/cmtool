class HtmlEdit
  setup: ->
    #ACE
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
      editor.getSession().on 'change', (e)->
        value = editor.getValue()
        if template_field.length
          try
            template = Emblem.compile(Handlebars, value)
            result_value = template(page_vars)
            template_field.val value
            text_field.val result_value
        else
          text_field.val value
      text_field.hide()
      template_field.hide()
@html_edit = new HtmlEdit()
