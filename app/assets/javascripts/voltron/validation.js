Voltron.addModule('Validation', function(){
  var fields = ['#MERGE1', '#MERGE2', '#MERGE0']

  return {
    initialize: function(){
      $(fields.join(', ')).on('input focus', function(){
        $(this).next('.error').slideUp(200, function(){
          $(this).remove();
        });
      });

      $('#email_updates').on('submit', function(event){
        var isValid = true
        for(var i=0; i<fields.length; i++){
          var value = $(fields[i]).val().trim();
          if(value == ''){
            var error;
            if($(fields[i]).next('.error').length){
              error = $(fields[i]).next('.error');
            }else{
              error = $('<div />', { class: 'error' }).hide().html('This is a required field.');
              $(fields[i]).after(error);
            }
            error.slideDown(200);
            event.preventDefault();
            isValid = false;
          }
        }
        return isValid;
      });
    }
  };
}, true);