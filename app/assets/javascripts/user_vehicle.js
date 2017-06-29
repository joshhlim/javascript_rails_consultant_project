var ready = function() {
  $('button.mileage-update').on('click', function(e) {
    $(this).closest('.vehicle-info').find('.mileage-update-form').show();
    $(this).hide();
  })

  $(".vehicles").on("submit", "form.mileage-update-form", function(event){
  })

  $(".mileage-update-form").on("ajax:success", function(e, data){
    console.log("success", data)
    parsed = JSON.parse(data)
    parsed = JSON.parse(parsed)
    console.log(parsed.services)
    $("#vehicle-" + parsed.vehicle_id).find("p").replaceWith("<p><strong>Mileage</strong> " + parsed.vehicle_mileage + "</p>");
    if (parsed.services === "") {
      $(".maintenance-info").hide();
    }
    else {
      $('.maintenance-info').show();
    }

  })
}

$(document).on("turbolinks:load", ready)
$(document).ready(ready)
