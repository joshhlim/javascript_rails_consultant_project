# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('[data-toggle="popover"]').popover()
  $("body").on "click", (e) ->
    $('[data-toggle="popover"]').each ->
      #the 'is' for buttons that trigger popups
      #the 'has' for icons within a button that triggers a popup
      $(this).popover "hide"  if not $(this).is(e.target) and $(this).has(e.target).length is 0 and $(".popover").has(e.target).length is 0
      return

    return

  $('[data-toggle="tooltip"]').tooltip()
  return
    
 
$ ->
  $("a.zf-confirm").click ->
    $(this).closest("li, tr").find(".text").toggleClass("confirmed").fadeIn 300
    $(this).toggleClass("confirmed in-active")
    $(this).closest("li, tr").find(".zf-reject").toggleClass("in-active")
    true

  return
  
$ ->
  $("a.zf-reject").click ->
    $(this).closest("li, tr").find(".text").toggleClass("rejected")
    $(this).toggleClass("rejected in-active")
    $(this).closest("li, tr").find(".zf-confirm").toggleClass("in-active")
    true

  return

$ ->
  $("a.zf-minus").click ->
    $(this).closest("li, tr").find(".text").toggleClass("rejected")
    $(this).toggleClass("rejected in-active")
    $(this).closest("li, tr").find(".zf-confirm").toggleClass("in-active")
    true

  return
  
$ ->
  $("a.zf-add").click ->
    $(this).toggleClass("added in-active")
    true

  return

$ ->
  $("#update-request-button").click ->
    $(this).toggleClass("disabled")
    true

  return


