$(document).ready ->
  editor = ace.edit("editor")

  $(".snippet-form-holder form").submit ->
    $(".snippet-file-content").val(editor.getValue())

  editor.setTheme("ace/theme/chrome")
  editor.getSession().setMode("ace/mode/javascript")
  editor.resize()
  editor.setHighlightActiveLine(true)
  editor.insert("# hello\n ## world");
  editor.setKeyboardHandler("ace/keyboard/vim");
  editor.getSession().setTabSize(2)
  document.getElementById('editor').style.fontSize='20px !important'
  editor.setReadOnly(false);
  $('#submit').click ->
    code = editor.getSession().getValue()
    $.post '/snippets',
      snippet:
        content: code