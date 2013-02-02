$ ->
  $('.redactor_intro').redactor
    lang: 'ru'
    minHeight: 150
    autoresize: false

  $('.redactor_content').redactor
    lang: 'ru'
    minHeight: 450
    autoresize: false
    # buttons: ['html', '|', 'formatting', '|', 'bold', 'italic', 'deleted', '|', 'unorderedlist', 'orderedlist', 'outdent', 'indent', '|', 'image', 'video', 'file', 'table', 'link', '|','fontcolor', 'backcolor', '|', 'alignleft', 'aligncenter', 'alignright', 'justify', '|', 'horizontalrule']
