(function($) {
  $('[data-toggle-menu]').on("click", function(e){
    e.preventDefault();
    $("#overlay-nav-menu").toggleClass("is-open");
  });

  $photos = $(".photos a.photo")

  $(".photos a.photo").click(function(e) {
    var target = e.target || e.srcElement;
    var link = target.src ? target.parentNode : target;
    var options = {
      index: link,
      event: e,
      onopen: function() {
        // console.log('open');
      },
      onopened: function() {
        // console.log('opened');
      },
      onslide: function(index, slide) {
        // console.log('slide', index, slide);
        var description = $(this.list[index]).data("description");
        $("#blueimp-gallery .description").html(description);
      },
      onslideend: function(index, slide) {
        // console.log('slideend', index, slide);
      },
      onslidecomplete: function(index, slide) {
        // console.log('slidecomplete', index, slide);
      },
      onclose: function() {
        // console.log('close');
      },
      onclosed: function() {
        // console.log('closed');
      }
    };

    blueimp.Gallery($photos, options);
  });

  $('#blueimp-gallery')
})(jQuery);
