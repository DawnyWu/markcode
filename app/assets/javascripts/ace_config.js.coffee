$(document).on 'ready', ->
  $render_file = $('.render_file')
  mode_name = "text"

  $(document).on 'change', '#indent_size', (e) ->
    editor.getSession().setTabSize(e.target.value)

  $(document).on 'click', '#vim_mode', ->
    $("#emacs_mode").prop("checked", false);
    if this.checked
      editor.setKeyboardHandler("ace/keyboard/vim")
    else
      editor.setKeyboardHandler("")

  $(document).on 'click', '#emacs_mode', ->
    $("#vim_mode").prop("checked", false);
    if this.checked
      editor.setKeyboardHandler("ace/keyboard/emacs")
    else
      editor.setKeyboardHandler("")

  $(document).on 'input', '#snippet_name', ->
    file_name = $("#snippet_name").val()
    mode = modelist.getModeForPath(file_name).mode
    mode_array = mode.split('/')
    mode_name = mode_array[mode_array.length-1]
    $render_file.text("Will rendered as " + mode_name.toUpperCase())
    editor.getSession().setMode(mode)

  modelist = ace.require("ace/ext/modelist")
  editor = ace.edit("editor")
  editor.setTheme("ace/theme/chrome")
  editor.getSession().setMode('ace/mode/text')
  editor.resize()
  ace.config.set("basePath", "/ace");
  editor.autoIndent = true
  editor.setHighlightActiveLine(true)
  editor.getSession().setTabSize(2)

  document.getElementById('editor').style.fontSize='20px !important'
  editor.setReadOnly(false);

  window.onbeforeunload = (e)->
    if editor.getValue()
      "Your changes will be lost."

  $(".snippet-form-holder form").submit ->
    $(".snippet-file-language").val(mode_name)
    $(".snippet-file-content").val(editor.getValue())