Jekyll::Hooks.register :site, :post_write do |site|
  json = File.read('_data/site.json')
  system('mkdir _site/data')
  File.open('_site/data/site.json', 'w+') do |f|
    f.write(json)
  end
end

