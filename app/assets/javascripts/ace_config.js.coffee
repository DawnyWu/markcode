$(document).on 'ready', ->
  editor = ace.edit("editor")
  console.log "change"
  $(document).on 'input', '#snippet_name', ->
    file_name = $("#snippet_name").val()
    console.log file_name
    mode = modelist.getModeForPath(file_name).mode
    console.log mode
    editor.getSession().setMode(mode)
  modelist = ace.require("ace/ext/modelist")
  editor = ace.edit("editor")
  editor.setTheme("ace/theme/chrome")
  # editor.setTheme("ace/theme/github")
  editor.getSession().setMode('ace/mode/text')
  editor.resize()
  editor.autoIndent = true
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