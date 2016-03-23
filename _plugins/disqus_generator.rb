require 'securerandom'
require 'json'


module Disqus
  class Generator < Jekyll::Generator
    PATH = '_data/disqus_ids.json'

    # Generates a JSON file in the _data/
    # directory with a hash of unique
    # slug => disqus_id
    # pairs namespaced under the title of the
    # site
    def generate(site)
      disqus_ids = generate_disqus_ids(site)
      write_file(disqus_ids)
    end




    private
    def generate_disqus_ids(site)
      disqus_ids = {}
      site_md5 = Digest::MD5.new.hexdigest(site.config['title'])
      site.posts.docs.reverse.each do |doc|
        slug = doc.data['slug']
        slug_md5 = Digest::MD5.new.hexdigest(slug)
        disqus_id = "#{site_md5}-#{slug_md5}"
        disqus_ids[slug] = disqus_id
        doc.data['disqus_id'] = disqus_id
      end
      disqus_ids
    end


    def write_file(disqus_ids)
      File.open(PATH, 'w+') do |f|
        json = JSON.pretty_generate(disqus_ids)
        f.write(json + "\n")
      end
    end
  end
end

