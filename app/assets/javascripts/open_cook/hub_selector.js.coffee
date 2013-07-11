class @HubSelector
  @download_hub_children = (item) ->
    field = item.parent()
    selector_holder = item.parents('.hub_selector')

    $.ajax
      type: 'POST'
      url: '/hubs/selector'
      data:
        id:     $('#post_id').val()
        klass:  $('#post_klass').val()
        hub_id: $(item).val()
      success: (data, status, response) ->
        if data.length is 0
          field.nextAll().remove()
        else
          selector_holder.append data

  @init = ->
    selector_holder = $('.hub_selector')
    return false if selector_holder.length is 0

    $('a.other_hub').click ->
      $('a.other_hub, .hub_full_name').hide()
      $('.hub_selector').show()

    selector_holder.on 'change', 'select', (e) =>
      item = $ e.target
      @download_hub_children(item)

    # run once on load
    first_select = $('select', selector_holder)
    @download_hub_children(first_select)