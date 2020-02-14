(function($) {
  $('[data-toggle-menu]').on("click", function(e){
    e.preventDefault();
    $("#overlay-nav-menu").toggleClass("is-open");
  });
})(jQuery);
