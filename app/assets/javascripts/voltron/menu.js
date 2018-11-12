Voltron.addModule('Menu', function(){
  return {
    initialize: function(){
      $(document).on('click', '.sidebar-menu', function(){
        $('.layout-two-column-left').toggleClass('open');
      });

      $(document).on('click', '.sidebar-close', function(){
        $('.layout-two-column-left').removeClass('open');
      });

      $(document).on('click', function(event){
        if(!$(event.target).closest('.sidebar').length && !$(event.target).closest('.sidebar-menu').length){
          $('.layout-two-column-left').removeClass('open');
        }
      });
    }
  };
}, true);
