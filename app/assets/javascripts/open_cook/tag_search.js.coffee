@TagSearch = 
  show_basic: ->
    @result.hide()
    @basic.slideDown 250

  show_result: ->
    @basic.hide()
    @result.slideDown 250

  init: ->
    input = $('.tag_search input')
    block = input.parent()

    collection = input.siblings '.collection'
    @result    = input.siblings '.result'
    @basic     = input.siblings '.basic'

    input.blur (e) =>
      @show_basic() if $(e.target).val().trim().length is 0

    input.keyup (e) =>
      input = $(e.target)
      word  = input.val().toLowerCase()
      num   = parseInt word

      if word.length is 0
        return @show_basic()
      
      finded = []
      int_search = if isNaN(num) then false else true
      
      tags = $ 'p', collection

      if int_search
        tags.each (i, tag) ->
          counter = $(tag).data('count')
          counter = parseInt counter
          finded.push tag if num is counter
      else
          tags.each (i, tag) ->
            _tag = $(tag).data 'tag'
            finded.push tag if _tag.match(word) isnt nil

      finded.sort (a,b) ->
        pattern = new RegExp "^#{word}"
        a = $(a).data('tag')
        b = $(b).data('tag')
        a = a.match pattern
        b = b.match pattern
        return if a is nil then 1 else -1

      @result.empty().append $(finded).clone()
      @show_result()