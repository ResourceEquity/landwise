require 'aws-sdk'

class SitemapJob < ApplicationJob

  queue_as :default

  def perform
    SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new("#{Rails.application.credentials.aws[:bucket]}-#{Rails.env}",
      aws_access_key_id: Rails.application.credentials.aws[:access],
      aws_secret_access_key: Rails.application.credentials.aws[:secret],
      aws_region: Rails.application.credentials.aws[:region]
    )
    SitemapGenerator::Sitemap.default_host = Rails.application.config.action_mailer.asset_host
    SitemapGenerator::Sitemap.create(compress: Rails.env.production?, include_root: false) do
      add new_user_session_path,      lastmod: Time.current, priority: 0.1, changefreq: 'never'
      add new_user_registration_path, lastmod: Time.current, priority: 0.1, changefreq: 'never'
      add new_user_password_path,     lastmod: Time.current, priority: 0.1, changefreq: 'never'
      add new_user_confirmation_path, lastmod: Time.current, priority: 0.1, changefreq: 'never'
      add library_index_path,         lastmod: Time.current, priority: 0.9, changefreq: 'monthly'

      records = Record.search do
        fulltext '*'

        with :published, true
        with :roles, [Responsibility.find_by(title: 'Public').id]

        paginate page: 1, per_page: Record.count
      end

      records.results.each do |record|
        add record_path(record), lastmod: record.updated_at, priority: 0.9, changefreq: 'daily'
      end

      guides = Guide.search do
        fulltext '*'
        with :published, true

        paginate page: 1, per_page: Guide.count
      end

      guides.results.each do |guide|
        guide.articles.each do |article|
          add guide_article_path(guide, article), lastmod: article.updated_at, priority: 0.8, changefreq: 'daily'
        end
      end

      Page.all.each do |page|
        add "/#{page.slug}", lastmod: page.updated_at, priority: 0.5, changefreq: 'monthly'
      end
    end

    SitemapGenerator::Sitemap.ping_search_engines if Rails.env.production?
  end
end
