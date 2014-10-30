path = Rails.root.join('db', 'seeds', "development.rb")
load path if File.exist?(path)
