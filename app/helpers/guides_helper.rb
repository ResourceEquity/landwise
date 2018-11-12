module GuidesHelper

  def author_links(guide, interactive=true)
    guide.users.map { |user| link_to(user.name, guides_path(user_ids: user.id), class: interactive ? 'interactive-link' : '') }.to_sentence.html_safe
  end

end
