class YmlEdit
  setup: ->
    #ACE
    $('.yml-content').each (i, el)->
      text_field = $(el)
      ace_div = $('<div></div>').addClass('ace-div') #.html(text_field.val())
      text_field.after ace_div
      ace_div.css
        width: '100%'
        height: '600px'
      editor = ace.edit(ace_div.get(0))
      editor.setTheme 'ace/theme/monokai'
      editor.getSession().setMode 'ace/mode/yaml'
      editor.getSession().setValue text_field.val()
      editor.getSession().setTabSize(2)
      editor.getSession().setUseSoftTabs(true)
      editor.getSession().on 'change', (e)->
        text_field.val(editor.getValue()).change()
      text_field.hide()
    #ace_div.hide()
@yml_edit = new YmlEdit()
