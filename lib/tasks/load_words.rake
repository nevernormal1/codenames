namespace :words do
  task :load, [:file_name] => :environment do |task, args|
    File.foreach(Rails.root.join("db", args[:file_name])) do |word|
      Word.create!(value: word.chomp)
    end
  end
end
