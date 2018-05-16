desc 'clear all votes and reset encryption keys'
task :reset_db => :environment do
  puts "resetting up..."
  Vote.collection.drop
  User.update_all(encryption_key:nil)
  puts "done!!"
end
