require 'colorize'
require 'securerandom'

task import: :environment do
  public_role = Responsibility.find_by(title: 'Public')
  admin_role = Responsibility.find_by(title: 'Admin')
  restricted_role = Responsibility.find_by(title: 'Restricted')

  users = JSON.parse(File.read(Rails.root.join('lib', 'tasks', 'users.json')))
  users.each_with_index do |u, index|
    password = SecureRandom.hex(32)

    user = User.create!(
      first_name: u['first_name'],
      last_name: u['last_name'],
      email: "eric+#{index}@ckdtech.co",
      contact: u['contact'],
      title: u['title'],
      bio: u['bio'],
      password: password,
      password_confirmation: password,
      author: true,
      confirmed_at: Time.now
    )

    user.responsibilities << admin_role unless user.responsibilities.any? { |r| r.title == 'Admin' }

    if u['avatar']['url'].present?
      begin
        user.avatar.attach(io: open(u['avatar']['url']), filename: u['avatar']['filename'], content_type: u['avatar']['content_type'])
      rescue Errno::ENOENT, OpenURI::HTTPError => e
        puts "Cannot find url: #{u['avatar']['url']}".red
      end
    end
  end

  current = nil
  records = JSON.parse(File.read(Rails.root.join('lib', 'tasks', 'records.json')))

  records.each do |r|
    begin
      current = r

      category = Category.find_by!(title: r['category'])
      jurisdiction = Jurisdiction.find_by!(title: r['jurisdiction'])
      topics = r['topics'].map { |title| Topic.find_by!(title: title) }
      countries = r['countries'].map { |title| Country.find_by!(title: title) }
      restricted = topics.any? { |t| t.title == 'Restricted Access' }

      record = Record.new(
        id: r['id'],
        created_at: Time.parse(r['created_at']),
        updated_at: Time.parse(r['updated_at']),
        title: r['title'],
        creator: r['creator'],
        description: r['description'],
        published: r['published'],
        topic_ids: topics.map(&:id),
        country_ids: countries.map(&:id),
        category: category,
        jurisdiction: jurisdiction,
        author: r['author'],
        notes: r['notes']
      )

      record.save!(without_protection: true)

      record.responsibilities << admin_role
      record.responsibilities << public_role unless restricted
      record.responsibilities << restricted_role if restricted

      r['items'].each do |i|
        languages = i['languages'].map { |title| Language.find_by!(title: title) }

        item = record.items.create(
          title: i['title'],
          description: i['description'],
          created_at: Time.parse(i['created_at']),
          updated_at: Time.parse(i['updated_at']),
          url: i['url'],
          year: i['year'],
          published: i['published'],
          language_ids: languages.map(&:id)
        )

        if i['document']['url'].present? && !Rails.env.development?
          begin
            item.document.attach(io: open(i['document']['url']), filename: i['document']['filename'], content_type: i['document']['content_type'])
          rescue Errno::ENOENT, OpenURI::HTTPError => e
            puts "Cannot find url: #{i['document']['url']}"
          end
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      puts 'Not Found'
      puts e.message
      puts current.to_yaml
    rescue ActiveRecord::RecordInvalid => e
      puts 'Record Invalid'
      puts e.message
      puts current.to_yaml
    end
  end

  guides = JSON.parse(File.read(Rails.root.join('lib', 'tasks', 'guides.json')))
  guides.each do |g|
    guide = Guide.new(
      id: g['id'],
      title: g['title'],
      created_at: Time.parse(g['created_at']),
      updated_at: Time.parse(g['updated_at']),
      published: g['published']
    )

    g['subjects'].each do |s|
      guide.subjects << Subject.find_or_create_by(title: s)
    end

    g['countries'].each do |c|
      guide.countries << Country.find_or_create_by(title: c)
    end

    g['authors'].each do |a|
      guide.users << User.find_by!(first_name: a['first_name'], last_name: a['last_name'])
    end

    g['articles'].each do |a|
      article = guide.articles.build(
        id: a['id'],
        title: a['title'],
        position: a['position'],
        created_at: Time.parse(a['created_at']),
        updated_at: Time.parse(a['updated_at'])
      )

      a['sections'].each do |s|
        article.sections.build(
          title: s['title'],
          body: s['body'],
          position: s['position'],
          created_at: Time.parse(s['created_at']),
          updated_at: Time.parse(s['updated_at'])
        )
      end
    end

    guide.save!(without_protection: true)
  end

  pages = JSON.parse(File.read(Rails.root.join('lib', 'tasks', 'pages.json')))
  pages.each do |p|
    Page.create!(
      title: p['title'],
      keywords: p['keywords'],
      description: p['description'],
      body: p['body'],
      slug: p['slug']
    )
  end

  # Change the auto increment id to something higher than the highest id found, to avoid conflict
  id = Record.all.order(id: :desc).first.id
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE records_id_seq RESTART WITH #{id + 1}")

  id = Guide.all.order(id: :desc).first.id
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE guides_id_seq RESTART WITH #{id + 1}")

  id = Article.all.order(id: :desc).first.id
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE articles_id_seq RESTART WITH #{id + 1}")
end