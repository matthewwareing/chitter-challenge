require 'pg'
require 'database_connection'
if ENV['RACK_ENV'] != 'production'
  require 'rspec/core/rake_task'
  
  RSpec::Core::RakeTask.new :spec
  
  task default: [:spec]

  task :test_database_setup do
    p "Cleaning database"
    DatabaseConnection.setup('chitter_test')

    # Clear the database
    DatabaseConnection.query("TRUNCATE peeps;")
    DatabaseConnection.query("TRUNCATE users;")
  end

  task :setup do
    p 'Creating databases...'

    ['chitter', 'chitter_test'].each do |database|
      connection = PG.connect
      connection.exec("CREATE DATABASE #{database};")
      DatabaseConnection.setup(database)
      DatabaseConnection.query("CREATE TABLE peeps(id SERIAL PRIMARY KEY, content VARCHAR(140), date timestamp);")
      DatabaseConnection.query("CREATE TABLE users(id SERIAL PRIMARY KEY, username VARCHAR(140),
      display_name VARCHAR(140), email VARCHAR(140), password VARCHAR(140));")
    end
  end

  task :teardown do
    p "Destroying databases..type 'y' to confirm that you want to destroy the Bookmark Manager databases. This will remove all data in those databases!"

    # Get a confirmation from the user!
    confirm = STDIN.gets.chomp
    return unless confirm == 'y'

    ['chitter', 'chitter_test'].each do |database|
      connection = PG.connect
      # Drop each database in the list
      connection.exec("DROP DATABASE #{database}")
    end
  end
end
