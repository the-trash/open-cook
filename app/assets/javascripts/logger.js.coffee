@log = -> console.log.apply(console, arguments)

class @MultiInput
  @init = ->
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

class @App
  @init_post_edit_meta_fields = ->
    block = $('.meta_fields')
    block.on 'click', 'a', ->
      link  = $ @
      itag  = $('i', link)
      set   = $('.set', block)
      kup   = 'icon-arrow-up'
      kdown = 'icon-arrow-down'

      if itag.hasClass kdown
        itag.removeClass(kdown).addClass(kup)
        set.fadeIn()
      else
        itag.addClass(kdown).removeClass(kup)
        set.fadeOut()

      false

  @init_pub_type_select = ->
    $('.pub_type_select select').change ->
      $.ajax
        type: 'POST'
        url: '/hubs/selector'
        data:
          id: $('#post_id').val()
          klass: 'Post'
          pub_type: $(@).val()
        success: (data, status, response) ->
          $('.hub_select').html data

  @init_flash_messages_close = ->
    $('.flash_msgs').on 'click', 'a.close', ->
      $(@).parent().hide()
$ ->
  App.init_post_edit_meta_fields()
  App.init_flash_messages_close()
  App.init_pub_type_select()
  MultiInput.init()