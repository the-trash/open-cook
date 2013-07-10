class @HubSelector
  @init = ->
    $('.hub_selector').on 'change', 'select', ->
      $.ajax
        type: 'POST'
        url: '/hubs/selector'
        data:
          id:     $('#post_id').val()
          klass:  $('#post_klass').val()
          hub_id: $(@).val()
        success: (data, status, response) ->
          $('.hub_selector').append data