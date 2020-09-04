Voltron.addModule('Search', function(){
  return {
    initialize: function(){
      $(document).on('click', '.filter-button, .filter-link', this.toggleAdvanced);
      $(document).on('click', '.button-apply', function(){
        Voltron('Search/toggleAdvanced', true);
      });

      $(document).on('mousedown', function(event){
        if(!$(event.target).closest('.search-wrapper').length){
          Voltron('Search/toggleAdvanced', true);
        }
      });
    },
    toggleAdvanced: function(close){
      $('.search').toggleClass('is-advanced', close === true ? false : undefined);
      $('.filter-button').toggleClass('is-active', ($('#country_ids').val() !== null || $('#topic_ids').val() !== null) || $('.search').hasClass('is-advanced'));
      if($('.search').hasClass('is-advanced')){
        $('.advanced-search').fadeIn(250);
      }else{
        $('.advanced-search').fadeOut(250);
      }
    }
  };
}, true);
