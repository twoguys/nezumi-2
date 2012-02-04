function load_page() {
  var $link = $(this);
  var $parent = $link.parent();
  if ($parent.hasClass('active')) { return false; }
  
  $link.parent().addClass('active').siblings().removeClass('active');
  
  // var width = $('body').width() + 200;
  // var $swiper = $('#swiper');
  // $swiper.animate({right: width + 'px'}, 500, 'easeInQuint', function() {
  //   $swiper.hide().css({right: '-' + width + 'px'}).show();
  // });
  // 
  // $.get($link.attr('href'), {remote: true}, function(result) {
  //   $swiper.html(result).animate({right: 0}, 500, 'easeInQuint');
  // });
  
  var $content = $('#content');
  var $content_inner = $('#content-inner');
  $content_inner.fadeOut(200, function() {
    $content.addClass('loading');
  });
  $.get($link.attr('href'), {remote: true}, function(result) {
    $content.removeClass('loading');
    $content_inner.html(result).fadeIn(200);
    window.history.pushState(null, 'Nezumi ' + $link.attr('data'), '/#' + $link.attr('href'));
  });
  
  return false;
}


$(function() {
  root_url = window.location.href;  
  $('#header nav a').click(load_page);
  
  window.onpopstate = function(event) {
    console.log(event.currentTarget);
  }
  
  if (window.location.href.indexOf('#') != -1) {
    
  }
});