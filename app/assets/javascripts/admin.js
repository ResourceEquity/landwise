//= require ckeditor/init
//= require jquery
//= require rails-ujs
//= require voltron-flash
//= require cocoon
//= require vendor/sortable.min
//= require vendor/jquery.selectric
//= require_tree ./voltron

var Admin = (function(){
  return {
    initialize: function(){
      CKEDITOR.config.customConfig = CKEDITOR_CONFIG;

      var self = this;

      $('textarea').each(function(){
        self.makeWysiwyg(this);
      });

      $('.sortable').each(function(){
        self.makeSortable(this);
      });

      $(document).on('cocoon:after-insert', '.sections-wrapper, .record-items, .guide-articles', function(event, item){
        var id = new Date().getTime().toString();
        $(item).find('.sections-wrapper').attr('id', 'sections_' + id).attr('data-group', 'sections_' + id);

        $(item).find('.sortable').each(function(){
          self.makeSortable(this);
        });
        $(item).find('textarea').each(function(){
          self.makeWysiwyg(this);
        });
      });

      $(document).on('submit', 'form', function(){
        self.setPositions();
      });
    },
    toggleSection: function(button){
      $(button).closest('.header').nextAll('.sections').slideToggle(250);
    },
    makeWysiwyg: function(elm){
      CKEDITOR.replace(elm.id);
    },
    makeSortable: function(elm){
      new Sortable(elm, {
        group: $(elm).data('group'),
        handle: '.handle'
      });
    },
    setPositions: function(){
      $('.sortable').each(function(){
        var selector = '.' + $(this).data('selector');
        var wrapper = this;
        $(this).find(selector).each(function(){
          var index = $(this).index(selector);
          $(this).children('.position').val(index);
        });
      });
    }
  };
})();

Admin.initialize();