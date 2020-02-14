(function($) {
  $('[data-toggle-menu]').on("click", function(e){
    e.preventDefault();
    $("#overlay-nav-menu").toggleClass("is-open");
  });

  $photos = $(".photos a.photo")

  $(".photos a.photo").click(function(e) {
    e.preventDefault();
    e.stopPropagation();

    blueimp.Gallery($photos);
  });
})(jQuery);
