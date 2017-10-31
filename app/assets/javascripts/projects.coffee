# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#@sw_alert = (it) ->
#    console.log(it)
#    return false

$(document).ready ->
    $('#habit-show .card-header .btn-header').click ->
        link_to($(this).data('href'))

    $('#prj-delete-confirm').click ->
        text_box = $('#modal-prj-destroy input')
        text = text_box.val()

        title_box = $('#habit-show').find('.card-header').find('h2').find('span')
        title = title_box.text()

        msg = $('#modal-prj-destroy').find('.invalid_msg')

        if text == title
            url = $(this).data('href')
            $.ajax(
                url: url+'.json'
                method: 'delete'
                data: authenticity_token: $tk).done (data) ->
                    window.location = data.path
                    return
        else
            if title.replace(' ', '').length == 0
                msg.show()
            else
                msg.show()

    $('#modal-prj-destroy input').click ->
        $('#modal-prj-destroy').find('.invalid_msg').hide()