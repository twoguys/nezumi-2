function nav_clicked() {
  var $link = $(this);
  var $parent = $link.parent();
  if ($parent.hasClass('active')) { return false; }
  
  load_url($link.attr('href'));
  store_state('/#/' + $link.attr('href'));
  
  return false;
}

function store_state(url) {
  if (history.pushState) {
    history.pushState({url: url}, 'Nezumi', url);
    console.log('state stored: ' + url);
  }
}

function load_url(url) {
  $('#' + url).addClass('active').siblings().removeClass('active');
  $('#content').addClass('loading');
  $.get(url, {remote: true}, function(result) {
    $('#content').html(result).removeClass('loading');
  });
}

/*
$(function() { 
  $('#header nav a').click(nav_clicked);
  
  window.onpopstate = function(event) {
    if (event.state != null) {
      var url = event.state.url.split('/#/')[1]; 
      load_url(url);
      $('#' + url).addClass('active').siblings().removeClass('active');
    }
  }
  
  if (window.location.href.indexOf('#') != -1) {
    var url = window.location.href.split('#/')[1];
    if (url != 'iphone') {
      load_url(url);
      store_state('/#/' + url);
    }
  } else {
    store_state('/#/iphone');
  }
});
*/