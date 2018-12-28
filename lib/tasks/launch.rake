require 'colorize'

task launch: :environment do
  Section.all.each do |section|
    content = section.body
    content.gsub! /http(s?):\/\/landwise\.resourceequity\.org/, ''
    content.gsub! /http(s?):\/\/landwise\.reourceequity\.org/, ''
    content.gsub! '/subguides/', '/articles/'
    content.gsub! '/record/', '/records/'
    section.update(body: content)
  end
end
