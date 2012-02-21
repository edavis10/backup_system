$(document).ready(function() {
  $('.toggle').click(function() {
    var toggleScope = $(this).parent();

    if (toggleScope.hasClass('open')) {
      // Close all hide, open all show
      toggleScope.removeClass('open');
      toggleScope.find('.show-toggle').show();
      toggleScope.find('.hide-toggle').hide();
    } else {
      // Open all hide, close all show
      toggleScope.addClass('open');
      toggleScope.find('.show-toggle').hide();
      toggleScope.find('.hide-toggle').show();
    }
  });
});
