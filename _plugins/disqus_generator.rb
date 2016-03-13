require 'securerandom'
require 'json'


module Disqus
  class Generator < Jekyll::Generator
    def generate(site)
      json = {}

      site_md5 = Digest::MD5.new.hexdigest(site.config['title'])

      site.posts.docs.reverse.each do |doc|
        slug = doc.data['slug']
        slug_md5 = Digest::MD5.new.hexdigest(slug)
        disqus_id = "#{site_md5}-#{slug_md5}"
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

