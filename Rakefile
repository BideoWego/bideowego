task default: %w[list]

desc "List all tasks"
task :list do
  output = `rake -T`
  puts output
end

desc "Deploy to production"
task :deploy do
  exec("surge _site")
end

desc "Open production website"
task :open do
  exec("open http://bideowego.com")
end

