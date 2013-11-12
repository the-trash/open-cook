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