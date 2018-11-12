require 'colorize'

task import: :environment do
  public_role = Responsibility.find_by(title: 'Public')

  users = JSON.parse(File.read('users.json'))
  users.each do |u|
    user = User.create!(
      first_name: u['first_name'],
      last_name: u['last_name'],
      email: u['email'],
      contact: u['contact'],
      title: u['title'],
      bio: u['bio'],
      password: 'password',
      password_confirmation: 'password',
      author: true
    )

    if u['avatar']['url'].present?
      begin
        user.avatar.attach(io: open(u['avatar']['url']), filename: u['avatar']['filename'], content_type: u['avatar']['content_type'])
      rescue Errno::ENOENT, OpenURI::HTTPError => e
        puts "Cannot find url: #{u['avatar']['url']}".red
      end
    end
  end

  current = nil
  records = JSON.parse(File.read('records.json'))

  records[0..100].each do |r|
    begin
      current = r

      category = Category.find_by!(title: r['category'])
      jurisdiction = Jurisdiction.find_by!(title: r['jurisdiction'])
      topics = r['topics'].map { |title| Topic.find_by!(title: title) }
      countries = r['countries'].map { |title| Country.find_by!(title: title) }

      record = Record.new(
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

      if r['first_name'].present? && r['last_name'].present?
        record.users << User.find_by!(first_name: r['first_name'], last_name: r['last_name'])
      end

      record.save!

      record.responsibilities << public_role

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
          restricted: i['restricted'],
          language_ids: languages.map(&:id)
        )

        if i['document']['url'].present?
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

  guides = JSON.parse(File.read('guides.json'))
  guides.each do |g|
    guide = Guide.new(
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

    guide.save!
  end

  pages = JSON.parse(File.read('pages.json'))
  pages.each do |p|
    Page.create(
      title: p['title'],
      keywords: p['keywords'],
      description: p['description'],
      body: p['body'],
      slug: p['slug']
    )
  end
end