init_post_edit_meta_fields = ->
  block = $ '.meta_block'

  block.on 'click', 'a', ->
    link  = $ @
    itag  = $ 'i', link
    set   = $ '.meta_fields'

    kup   = 'icon-arrow-up'
    kdown = 'icon-arrow-down'

    if itag.hasClass kdown
      itag.removeClass(kdown).addClass(kup)
      set.removeClass('hidden')
    else
      itag.addClass(kdown).removeClass(kup)
      set.addClass('hidden')

    false

$ -> init_post_edit_meta_fields()