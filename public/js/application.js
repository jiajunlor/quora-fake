$(document).ready(function(){
	var $email = $('#email');
    var $hint = $("#hint");

    $email.on('blur',function() {
      $hint.css('display', 'none').empty();
      $(this).mailcheck({
        suggested: function(element, suggestion) {
          if(!$hint.html()) {
            // First error - fill in/show entire hint element
            var suggestion = "Did you mean <span class='suggestion'>" +
                              "<span class='address'>" + suggestion.address + "</span>"
                              + "@<a href='#' class='domain'>" + suggestion.domain + 
                              "</a></span>?";
                              
            $hint.html(suggestion).fadeIn(150);
          } else {
            // Subsequent errors
            $(".address").html(suggestion.address);
            $(".domain").html(suggestion.domain);
          }
        }
      });
    });

    $hint.on('click', '.domain', function() {
      // On click, fill in the field with the suggestion and remove the hint
      $email.val($(".suggestion").text());
      $hint.fadeOut(200, function() {
        $(this).empty();
      });
      return false;
    });

});