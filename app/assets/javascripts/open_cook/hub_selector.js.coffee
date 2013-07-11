class @HubSelector
  @init = ->
    selector_holder = $('.hub_selector')
    selector_holder.on 'change', 'select', ->
      field = $(@).parent()

      $.ajax
        type: 'POST'
        url: '/hubs/selector'
        data:
          id:     $('#post_id').val()
          klass:  $('#post_klass').val()
          hub_id: $(@).val()
        success: (data, status, response) ->
          if data.length is 0
            field.nextAll().remove()
          else
            selector_holder.append data