Voltron.addModule('Select', function(){
  return {
    initialize: function(){
      $('select').selectric({
        labelBuilder: function(item){
          let $option = $(item.element);
          if($option.data('label')){
            return $option.data('label');
          }else{
            return $(item.element).text();
          }
        }
      });
    }
  }
}, true);