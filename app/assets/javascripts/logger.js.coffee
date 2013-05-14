@log = -> console.log.apply(console, arguments)

$ ->
  $('.test_multi').change (e) ->
    input = $ e.target
    
    # Build elements
    file_name = input.val()

    file_input = input.clone()
    file_input.css { height: 0, width: 0 }

    remove_button = " <a href='#' class='remove_attached_file'>[X]</a> "

    # build blocks
    attached_file = $("<div class='attached_file' />")
      .html(file_name)
      .append(file_input)
      .append(remove_button)

    # insert
    input.after attached_file

    # clear src input
    input.val('')
