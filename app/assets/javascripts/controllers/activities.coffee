scrollHandler = ->
  url = $(".actvty-pagination .next_page a").attr("href")
  if url and $(window).scrollTop() > $(document).height() - $(window).height() - 300
    $(".actvty-pagination").text "Nicht so schnell..."
    showSpinner()
    $.getScript url
  return

if $(".actvty-pagination").length
  $(window).scroll(scrollHandler)
  $(window).scroll()
  $(document).on 'page:load', ->
    $(window).off "scroll", scrollHandler

showActivitiesClickHandler = ->
  $(this).closest(".grouped-activities").children(".activity").each ->
    $(this).slideDown()
  $(this).parent().hide()
  
$(".show-activities").click showActivitiesClickHandler
