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
    iframe = $('#preview-modal iframe')
    params =
      body: $('#page_body').val()
      sidebar: $('#page_sidebar').val()
      footer: $('#page_footer').val()
      layout: $('#page_layout').val()
    $.post url, page: params, (response)->
      iframe.attr 'src', url
      $('#preview-modal').foundation('reveal', 'open')
    false
