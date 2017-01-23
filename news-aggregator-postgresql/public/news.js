$(document).ready(function() {
  $('form').submit(function(event){
    event.preventDefault();
    // alert("URL already submitted!");
    var checkUrl = $('#url')[0].value;


  });
});

var requestCheck = function(item)
  var request = $.ajax({
    method: "post",
    url: "/articles",
    data: { item: item }
  });

  request.done(function() {

  });
});
