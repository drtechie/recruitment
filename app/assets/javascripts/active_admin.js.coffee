#= require active_admin/base
#= require activeadmin_addons/all
#= require nested_form_fields
#= require active_admin/json_editor.js
#= require codemirror
#= require codemirror/modes/markdown
#= require codemirror/addons/mode/overlay
#= require codemirror/addons/selection/active-line
#= require codemirror/modes/javascript
#= require codemirror/modes/gfm

$ ->
  removeFromArrayInput = (el) ->
    textarea = $(el).siblings('textarea')
    myInstance = $(textarea).data('CodeMirrorInstance');
    if (myInstance)
      myInstance.setOption("readOnly", false)
      $(textarea)
        .parent()
        .find('.CodeMirror')
        .removeClass('readonly')
    if textarea.attr('disabled') == 'disabled'
      $(el)
        .html('-')
        .removeClass('can-undo')
      $(textarea).removeAttr('disabled')
      $(textarea).removeClass('text--strike')
    else
      $(el)
        .html('&#8630;')
        .addClass('can-undo')
      myInstance = $(textarea).data('CodeMirrorInstance');
      if (myInstance)
        myInstance.setOption("readOnly", true)
        $(textarea)
          .parent()
          .find('.CodeMirror')
          .addClass('readonly')
      $(textarea).attr('disabled', 'disabled')
      $(textarea).addClass('text--strike')

  $('[data-action="add"]').click (e) ->
    e.preventDefault
    if $(@).data('action') == 'add'
      original = $(@).parent()
      clone    = $(original).clone(true)
      clone_id = "clone_#{Math.floor((Math.random() * 100000) + 1)}"
      textarea    = $(clone).find('textarea')
      myInstance = $(textarea).data('CodeMirrorInstance');
      if $(textarea).val() != '' || (myInstance && myInstance.getValue() != '')
        # Remove error classes from original's textarea
        $(original)
          .find('textarea')
          .removeClass('has-error')
        console.log("called")
        # Reset clone's textarea
        $(textarea)
          .removeClass('has-error')
          .attr('id', clone_id)
          .val('')

        # Change action to remove
        $(@)
          .html('-')
          .data('action', 'remove')
        if (myInstance)
          $(clone)
            .attr('style', "")
          $(clone)
            .find('.CodeMirror')
            .remove()
        # Add clone and focus its input
        $(@).parent().parent().append $(clone)
        $("##{clone_id}").focus()
        if (myInstance)
          initializeMarkdownEl(textarea)


      else
        $(original)
          .find('textarea')
          .addClass('has-error')
          .focus()
    else
      removeFromArrayInput $(@)

  $('[data-action="remove"]').click (e) ->
    e.preventDefault
    removeFromArrayInput $(@)

$(document).ready ->
  initializeMarkdownEl = (el) ->
    editor = CodeMirror.fromTextArea $(el).get(0),
      lineNumbers: true
      mode: 'gfm'
    $(el).data('CodeMirrorInstance', editor);
    return
  initializeMarkdown = () ->
    if ('.codemirror-array').length > 0
      $('.codemirror-array').each ->
        initializeMarkdownEl(this)
        return
  window.initializeMarkdownEl = initializeMarkdownEl
  setTimeout(initializeMarkdown, 1000)