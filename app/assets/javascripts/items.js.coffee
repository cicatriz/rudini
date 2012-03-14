# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

loadVideo = (videoid, start, end) ->
  $('#video').html('')
  clearInterval(document.end_vid)

  document.vid = Popcorn.youtube('#video', 'http://www.youtube.com/watch?v='+videoid)
  document.vid.play(start)
  document.end_vid = setInterval(() ->
    console.log(document.vid.roundTime() + " " + end)
    if document.vid.roundTime() > end
      document.vid.pause()
      clearInterval(document.end_vid)
  , 1000)

showItem = (id) -> 
  $(".item-container > .item").hide()
  $('#item-' + id).show()
  History.pushState({item:id}, "Item" + id, "?item=" + id)


$ ->
  current_item = $.getUrlVar('item')
  if current_item
    showItem(current_item)
    
  console.log(History.getState().data.item)
  $('#search').change(() ->

    val = $('#search').val()
    console.log(val)
    if val != ""
      $('li').hide()
      $('li:icontains("'+val+'")').show()
    else
      $('li').show()
    
  )

  $('.play-btn').click(() ->
    el = $(this)
    loadVideo(el.data('videoid'), el.data('start'), el.data('end'))
    return false
  )

  $('#search-box').keyup(() ->

    val = $('#search-box').val()
    console.log(val)
    if val != ""
      $('.nav-list > li').hide()
      $('.nav-list > li:icontains("' + val + '")').show()
    else
      $('.nav-list > li').show()

  )

  $('.nav-list a').click(() ->
    el = $(this)
    ary = el.attr('id').split("-")
    id = ary[ary.length - 1]
    console.log(id)
    showItem(id)
    return false

  )

