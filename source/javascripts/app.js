(function($) {
  $('.overlay-nav-menu-toggle').on("click", function(e){
    e.preventDefault();
    $(".subnav-hero-subnav").toggleClass("is-open");
  });

  var $photos = $(".photos a.photo");

  var blueimpGallery;

  $photos.click(function(e) {
    var target = e.target || e.srcElement;
    var link = target;
    while(link.nodeName !== "A") {
      link = link.parentNode;
    }
    var options = {
      index: link,
      event: e,
      emulateTouchEvents: false,
      continuous: false,
      closeOnHashChange: false,
      onopen: function() {
        // console.log('open');
      },
      onopened: function() {
        // console.log('opened');
        window.location.hash = "blueimp-gallery";
      },
      onslide: function(index, slide) {
        // console.log('slide', index, slide);
        var productURL = $(this.list[index]).data("product-url");
        if(productURL) {
          $("#blueimp-gallery .caption a").show().attr("href", productURL);
        } else {
          $("#blueimp-gallery .caption a").hide();
        }
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
        blueimpGallery = undefined;

        if(window.location.hash === "#blueimp-gallery") {
          window.history.back();
        }
      }
    };

    blueimpGallery = blueimp.Gallery($photos, options);
  });

  $("#blueimp-gallery .caption a").click(function() {
    if(window.location.hash === "#blueimp-gallery") {
      blueimpGallery = undefined;
      window.history.back();
    }
  });

  window.onhashchange = function() {
    if(window.location.hash === "") {
      if(blueimpGallery) {
        blueimpGallery.close();
      }
    }
  }
})(jQuery);
