CKEDITOR.plugins.add('bubble',
{
	init: function(editor)
	{
		editor.addCommand('addDefinitionBubble', new CKEDITOR.dialogCommand('addDefinitionBubble'));

		editor.ui.addButton('Bubble',
		{
			label: 'Insert Definition',
			command: 'addDefinitionBubble',
			icon: this.path + 'images/bubble.gif'
		});

		if(editor.contextMenu){
			editor.addMenuGroup('myGroup');
			editor.addMenuItem('abbrItem',
			{
				label: 'Edit Definition',
				icon: this.path + 'images/bubble.gif',
				command: 'addDefinitionBubble',
				group: 'myGroup'
			});
			editor.contextMenu.addListener(function(element)
			{
				if(element){
					element = element.getAscendant('a', true);
				}
				if(element && !element.isReadOnly() && !element.data('cke-realelement')){
 					return { abbrItem: CKEDITOR.TRISTATE_OFF };
				}
				return null;
			});
		}

		CKEDITOR.dialog.add('addDefinitionBubble', function(editor){
			return {
				title: 'Add Definition',
				minWidth: 400,
				minHeight: 200,
				contents: [
					{
						id: 'definition',
						label: 'Definition',
						elements: [
							{
								type: 'text',
								id: 'definition_text',
								label: 'Text',
								validate: CKEDITOR.dialog.validate.notEmpty('Text cannot be empty'),
								required: true,
								commit: function(element){
									var text = this.getValue();
									element.setHtml(text);
								},
								setup: function(element)
								{
									this.setValue(element.getText());
								}
							},
							{
								type: 'text',
								id: 'definition_url',
								label: 'URL',
								commit: function(element){
									var url = this.getValue();
									if(url == ''){
										url = 'javascript:void(0);';
									}
									element.setAttribute('href', url);
									element.$.removeAttribute('data-cke-saved-href');
								},
								setup: function(element)
								{
									var href = element.getAttribute('href');
									if(href == 'javascript:void(0);'){
										href = '';
									}
									this.setValue(href);
								}
							},
							{
								type: 'textarea',
								id: 'definition_content',
								label: 'Definition',
								commit: function(element){
									var content = this.getValue();
									element.setAttribute('data-definition', content);
								},
								setup: function(element)
								{
									this.setValue(element.getAttribute("data-definition"));
								}
							}
						]
					}
				],
				onShow: function(){
					var sel = editor.getSelection(), element = sel.getStartElement();
					if(element){
						element = element.getAscendant('a', true);
					}
 
					if(!element || element.getName() != 'a' || element.data('cke-realelement')){
						element = editor.document.createElement('a');
						this.insertMode = true;
					}else{
						this.insertMode = false;
					}
 
					this.element = element;
 
					this.setupContent(this.element);
				},
				onOk: function(){
					var dialog = this;
					if(this.insertMode){
						this.element.setAttribute('class', 'definition');
						editor.insertElement(this.element);
					}
					this.commitContent(this.element);
				}
			};
		});
	}
});
