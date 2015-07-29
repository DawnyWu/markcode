$(document).on 'ready', ->
  editor = ace.edit("editor")
  $render_file = $('.render_file')
  mode_name = "text"
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
  editor.autoIndent = true
  editor.setHighlightActiveLine(true)
  editor.setKeyboardHandler("ace/keyboard/vim");
  editor.getSession().setTabSize(2)

  document.getElementById('editor').style.fontSize='20px !important'
  editor.setReadOnly(false);
  $(".snippet-form-holder form").submit ->
    $(".snippet-file-type").val(mode_name)
    $(".snippet-file-content").val(editor.getValue())