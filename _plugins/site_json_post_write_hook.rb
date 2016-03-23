Jekyll::Hooks.register :site, :post_write do |site|

  # Writes the site JSON file
  # to the _site directory after
  # the entire site has been generated
  json = File.read('_data/site.json')
  system('mkdir _site/data')
  File.open('_site/data/site.json', 'w+') do |f|
    f.write(json)
  end
end

