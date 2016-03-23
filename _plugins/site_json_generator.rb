require 'json'


module SiteJSON
  class Generator < Jekyll::Generator
    PATH = '_data/site.json'

    # Generates a JSON file of basically the
    # entire site
    def generate(site)
      json = {}
      blog = generate_blog(site)
      json.merge!(blog)
      json[:static_files] = generate_static_files(site)
      json[:projects] = generate_projects(site)
      json[:games] = generate_games(site)
      write_file(json)
    end




    private
    def generate_blog(site)
      blog = {}
      blog[:categories] = []
      blog[:tags] = []
      blog[:posts] = []
      blog[:archives] = []
      site.posts.docs.reverse.each do |doc|
        blog[:categories].concat(doc.data['categories'] || [])
        blog[:tags].concat(doc.data['tags'] || [])
        doc.data['date'] = doc.data['date'].to_s.gsub(/ \d\d:\d\d:\d\d \-\d\d\d\d/, '')
        blog[:archives] << doc.data['date'].gsub(/-\d\d$/, '')
        blog[:posts] << doc.data
      end
      blog[:archives].uniq!
      blog[:categories].uniq!
      blog[:tags].uniq!
      blog
    end


    def generate_projects(site)
      site.data['projects']
    end


    def generate_games(site)
      site.data['games']
    end


    def generate_static_files(site)
      static_files = []
      site.static_files.each do |file|
        static_files << {
          :extname => file.extname,
          :modified_time => file.modified_time,
          :url => file.url
        } if ['.png', '.jpg', '.gif'].include?(file.extname)
      end
      static_files
    end


    def write_file(json)
      File.open(PATH, 'w') do |f|
        json = JSON.pretty_generate(json)
        f.write(json + "\n")
      end
    end
  end
end

