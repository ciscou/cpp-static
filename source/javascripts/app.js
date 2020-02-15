(function($) {
  $('[data-toggle-menu]').on("click", function(e){
    e.preventDefault();
    $("#overlay-nav-menu").toggleClass("is-open");
  });

  $photos = $(".photos a.photo")

  $(".photos a.photo").click(function(e) {
    var target = e.target || e.srcElement;
    var link = target.src ? target.parentNode : target;
    var options = { index: link, event: e };

    blueimp.Gallery($photos, options);
  });
})(jQuery);
