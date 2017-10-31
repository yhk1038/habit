# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
protocol = 'http://'
host = 'localhost:3000'

$site =
    protocol: protocol
    host: host
    domain: protocol + host

# button tag 클릭했을 때 row onclick 속성 없이,
# 이벤트 기반으로 링크로 이동시키기 위한 헬퍼 메소드
@link_to = (url) ->
    window.location = url


# sm/md 구간에서 Sidebar 보이게.
display_sidebar = (width) ->
    width = $(window).width()
    logo = $('#header .logo')

    if width >= 768 && width < 1200
        logo.removeClass 'mobile'
        $('#menu-trigger').addClass 'open'
        $('#header').addClass 'sidebar-toggled'
        $('.current #sidebar').addClass 'toggled'
        $('.current #content').css 'padding-left', '268px'
    else
        logo.addClass 'mobile'
        $('#menu-trigger').removeClass 'open'
        $('#header').removeClass 'sidebar-toggled'
        $('.current #sidebar').removeClass 'toggled'
        $('.current #content').css 'padding-left', ''

    if width >= 1200
        logo.removeClass 'mobile'

    return

# 작은 화면에서 카드 중앙정렬로 리사이징
resizing = (width) ->
    target = $('.current .resizable')
    targetA = $('.current .resizable .habit:not(.creater)')
    targetB = $('.current .resizable .habit.creater')
    # t_width = targetA.width()

    if width < 850
        target.addClass 'flex-center-center m-b-30 w-100'
        targetB.css 'width', '285px'
        targetA.css 'width', '285px'
    else
        target.removeClass 'flex-center-center m-b-30 w-100'
        targetB.css 'width', ''
        targetA.css 'width', ''
    return

$(document).ready ->
    width = $(window).width()
    resizing(width)
    display_sidebar(width)

    $(window).resize ->
        new_width = $(window).width()
        resizing(new_width)
        display_sidebar(new_width)
    return