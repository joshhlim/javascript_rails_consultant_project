# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("a#maintenance-log-link").click ->
    $(this).toggleClass("in-active")
    $(this).find(".list-group-item-text").html("Feature not yet available")
    true

  return