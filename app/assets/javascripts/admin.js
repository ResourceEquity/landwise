//= require jquery
//= require rails-ujs
//= require voltron-flash
//= require cocoon
//= require vendor/sortable.min
//= require vendor/ckeditor
//= require vendor/jquery.selectric
//= require_tree ./voltron

var Admin = (function(){
  return {
    initialize: function(){
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
      ClassicEditor.create(elm, {
          toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote', '|', 'mediaEmbed', 'insertTable'],
          heading: {
            options: [
              { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
              { model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
              { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
              { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' },
              { model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4' },
              { model: 'heading5', view: 'h5', title: 'Heading 5', class: 'ck-heading_heading5' }
            ]
          }
        })
        .then(function(editor){
          //console.log(Array.from(editor.ui.componentFactory.names()));
        })
        .catch(function(error){
          console.error(error);
        });
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