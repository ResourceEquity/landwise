Voltron.addModule('Select', function(){
  return {
    initialize: function(){
      $('select:not(.select2)').selectric({
        labelBuilder: function(item){
          let $option = $(item.element);
          if($option.data('label')){
            return $option.data('label');
          }else{
            return $(item.element).text();
          }
        }
      }).selectricPlaceholder();
    }
  }
}, true);