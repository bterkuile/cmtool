#= require jquery
#= require jquery_ujs
#= require foundation
#= require ace/ace
#= require ace/theme-monokai
#= require ace/mode-coffee
#= require ace/mode-handlebars
#= require ace/mode-yaml
#= require ace/mode-haml
#= require tinymce-jquery
#= require_directory .
#= require_self

$ ->
  $(document).foundation()
  collapsible.setup()
  html_edit.setup()
  yml_edit.setup()
  $('.preview-page').click (ev)->
    ev.preventDefault()
    url = $(@).attr('href')
    params =
      body: $('#page_body').val()
      layout: $('#page_layout').val()
    $.post url, page: params, (response)->
      iframe = $('#preview-modal iframe').get(0)
      iframe.src = "data:text/html;charset=utf-8,#{escape(response)}"
      $('#preview-modal').foundation('reveal', 'open')
    false
