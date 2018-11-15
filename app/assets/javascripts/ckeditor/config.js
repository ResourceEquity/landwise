CKEDITOR.editorConfig = function(config){
  config.enterMode = CKEDITOR.ENTER_P;
  config.ignoreEmptyParagraph = true;
  config.fillEmptyBlocks = false;

  config.toolbar = [
    { name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'Source'] },
    { name: 'insert', items: [ 'Image', 'Table', 'SpecialChar' ] },
    { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
    { name: 'links', items: [ 'Link', 'Unlink' ] },
    '/',
    { name: 'styles', items: [ 'Format', 'Font', 'FontSize' ] },
    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
  ];

  config.font_names = 'Museo Sans;Museo Slab';
  config.fontSize_defaultLabel = '15';
  config.fontSize_sizes = '15/1.5rem;18/1.8rem;20/2rem;22/2.2rem;24/2.4rem';
  config.format_tags = 'p;h1;h2;h3;h4;h5;h6';

  config.contentsCss = CKEDITOR_STYLES;

  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures?";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";

  config.allowedContent = true;

  config.extraPlugins = 'autogrow';
};
