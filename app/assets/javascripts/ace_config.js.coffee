$(document).ready ->
  # file_name = "ruby.rb"
  # $(document).on 'input', '#snippet_name', ->
  #   file_name = $("#snippet_name").val()
  #   mode = modelist.getModeForPath(file_name).mode
  #   editor.getSession().setMode(mode)

  modelist = ace.require("ace/ext/modelist")
  editor = ace.edit("editor")
  editor.setTheme("ace/theme/chrome")
  editor.getSession().setMode('ace/mode/text')
  editor.resize()
  editor.setHighlightActiveLine(true)
  editor.setKeyboardHandler("ace/keyboard/vim");
  editor.getSession().setTabSize(2)
  document.getElementById('editor').style.fontSize='20px !important'
  editor.setReadOnly(false);
  $(".snippet-form-holder form").submit ->
    $(".snippet-file-content").val(editor.getValue())

# $.ajaxSetup({
#   cache: true
# });

# $.ajax({
#   url: "assets/ace/****",
#   dataType: "script",
#   success: success
# });