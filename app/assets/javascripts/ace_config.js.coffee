$(document).ready ->
  editor = ace.edit("editor")
  editor.setTheme("ace/theme/github")
  editor.resize()
  editor.setHighlightActiveLine(true)
  editor.setKeyboardHandler("ace/keyboard/vim");
  editor.getSession().setTabSize(2)
  document.getElementById('editor').style.fontSize='20px'
  editor.setReadOnly(false);
  $('#submit').click ->
    code = editor.getSession().getValue()
    $.post '/snippets',
      snippet:
        content: code