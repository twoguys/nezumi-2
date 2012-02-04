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
  });
  
  return false;
}

$(function() {
  $('#header nav a').click(load_page);
  
  if (window.location.href.indexOf('#') != -1) {
    
  }
});