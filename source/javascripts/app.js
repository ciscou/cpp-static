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
      emulateTouchEvents: false,
      onopen: function() {
        // console.log('open');
      },
      onopened: function() {
        // console.log('opened');
        window.location.hash = "blueimp-gallery";
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
        window.blueimpGallery = undefined;

        if(window.location.hash === "#blueimp-gallery") {
          window.history.back();
        }
      }
    };

    window.blueimpGallery = blueimp.Gallery($photos, options);
  });

  window.onhashchange = function() {
    if(window.location.hash === "") {
      if(blueimpGallery) {
        blueimpGallery.close();
      }
    }
  }
})(jQuery);
