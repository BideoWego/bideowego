require 'securerandom'
require 'json'


module Disqus
  class Generator < Jekyll::Generator
    def generate(site)
      json = {}


      site.posts.docs.reverse.each do |doc|
        slug = doc.data['slug']
        disqus_id = Digest::MD5.new.hexdigest(slug)
        json[slug] = disqus_id
        doc.data['disqus_id'] = disqus_id
      end


      File.open('_data/disqus_ids.json', 'w+') do |f|
        json = JSON.pretty_generate(json)
        f.write(json + "\n")
      end
    end
  end
end

