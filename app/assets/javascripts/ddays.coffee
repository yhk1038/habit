# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
protocol = 'http://'
host = 'localhost:3000'

$site =
    protocol: protocol
    host: host
    domain: protocol + host

ajax_call = (url, method, resource, data) ->
    dataSet = if data then data else 0
    call = $.ajax(
        url: $site.domain + url
        method: method
        data:
            authenticity_token: $tk
            dday: dataSet)
    call

it_has_this_class = (kind_of_class, target) ->
    class_list = $(target).attr('class').split(' ')
    result = undefined

    if $.inArray(kind_of_class, class_list) == -1
        # return for outer condition
        result = false
    else
        # return index position
        result = $.inArray(kind_of_class, class_list)

    result

$(document).ready ->
    $('.dday:not(.blocked)').click ->
        prj_id  = $(this).data 'habit_id'
        id      = $(this).data 'dday_id'
        url     = '/habits/'+prj_id+'/ddays/'+id+'.json'

        # Process : closed dday -> to alive
        if it_has_this_class 'closed', this
            $(this).removeClass 'closed'

            data = {success: false}
            ajax = ajax_call url, 'PUT', 'dday', data
            ajax.done (data) ->
#                console.log('changed!: ', data.success)
#                console.log(data)

        # Process : alive dday -> to close
        else
            $(this).addClass 'closed'

            data = {success: true}
            ajax = ajax_call url, 'PUT', 'dday', data
            ajax.done (data) ->
#                console.log('changed!: ', data.success)
#                console.log(data)

        return
    return

