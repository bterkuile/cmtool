#= require jquery
#= require jquery_ujs
#= require semantic-ui
#= require ace/ace
#= require moment
#= require ace/theme-monokai
#= require ace/mode-coffee
#= require ace/mode-handlebars
#= require ace/mode-json
#= require ace/mode-yaml
#= require ace/mode-haml
#= require ace/mode-slim
# require tinymce-jquery
# require tinymce
#= require pickadate/picker
#= require pickadate/picker.date
#= require pickadate/picker.time
#= require_directory .
#= require_self

$ ->
  $('.ui.dropdown').dropdown()
  $('.ui.checkbox').checkbox()
  $('.message .close.icon').on 'click', -> $(@).closest('.message').transition('fade')
  collapsible.setup()
  html_edit.setup()
  yml_edit.setup()
  $('.datepicker').pickadate()
  $('.preview-page').click (ev)->
    ev.preventDefault()
    url = $(@).attr('href')
    iframe = $('#preview-modal iframe')
    params =
      name: $('#page_name').val()
      menu_text: $('#page_menu_text').val()
      title: $('#page_title').val()
      body: $('#page_body').val()
      sidebar: $('#page_sidebar').val()
      footer: $('#page_footer').val()
      layout: $('#page_layout').val()
    $.post url, page: params, (response)->
      iframe.attr 'src', url
      $('#preview-modal').modal('show')
    false

  $("[data-time]").each ->
    $(this).text moment($(this).data("time")).format($(this).data("timeFormat") or "dd D MMM HH:mm")
