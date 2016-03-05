require 'json'

module MyGenerator
  class Generator < Jekyll::Generator
    def generate(site)
      json = {}


      json[:categories] = []
      json[:tags] = []
      json[:posts] = []
      site.posts.docs.reverse.each do |doc|
        json[:categories].concat(doc.data['categories'] || [])
        json[:tags].concat(doc.data['tags'] || [])
        json[:posts] << doc.data
      end
      json[:categories].uniq!
      json[:tags].uniq!


      json[:static_files] = []
      site.static_files.each do |file|
        json[:static_files] << {
          :extname => file.extname,
          :modified_time => file.modified_time,
          :url => file.url
        } if ['.png', '.jpg', '.gif'].include?(file.extname)
      end


      json[:projects] = []
      site.data['projects'].each do |project|
        json[:projects] << project
      end


      json[:games] = []
      site.data['games'].each do |game|
        json[:games] << game
      end


      File.open('_data/site.json', 'w') do |f|
        json = JSON.pretty_generate(json)
        f.write(json + "\n")
      end
    end
  end
end

