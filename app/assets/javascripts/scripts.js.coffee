$ ->
  $(".flash").delay(5000).slideUp ->
    $(this).remove()

  area = $('textarea.ace-editor')
  area.hide()
  editor = ace.edit($('div#ace-editor')[0])
  editor.getSession().setValue(area.val())
  editor.getSession().setTabSize(2)
  editor.getSession().setUseSoftTabs(true)
  editor.getSession().on 'change', ->
    area.val(editor.getSession().getValue())
