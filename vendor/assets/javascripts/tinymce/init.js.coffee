# newdocument bold italic underline strikethrough
# alignleft aligncenter alignright alignjustify
# styleselect formatselect fontselect fontsizeselect
# cut copy paste bullist numlist outdent indent blockquote undo redo
# removeformat subscript superscript
$ ->
  tinymce.init
    selector: ".redactor_intro, .redactor_content"
    language_url : '/assets/tinymce/langs/ru.js'
    plugins : 'code image link lists anchor table'
    menubar : false
    statusbar : false
    height : 300
    toolbar: "image link | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | bullist numlist | outdent indent | table | fontselect | fontsizeselect | styleselect | removeformat | code"