require 'find'
namespace :db do  
  desc "Backup the database to a file. Options: DIR=base_dir Rails.env=production MAX=20" 
  task :backup => [:environment] do
    datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")    
    base_path = ENV["DIR"] || "../db_backups" 
    backup_base = File.join(base_path, 'backup')
    backup_folder = File.join(backup_base, datestamp)
    backup_file = File.join(backup_folder, "#{Rails.env}_dump.sql.gz")    
    FileUtils.makedirs(backup_folder)    
    db_config = ActiveRecord::Base.configurations[Rails.env]    
    sh "mysqldump -u #{db_config['username']} -p#{db_config['password']} -Q --add-drop-table -O add-locks=FALSE -O lock-tables=FALSE #{db_config['database']} | gzip -c > #{backup_file}"     
    dir = Dir.new(backup_base)
    all_backups = dir.entries[2..-1].sort.reverse
    puts "Created backup: #{backup_file}"     
    max_backups = ENV["MAX"].to_i || 20
    unwanted_backups = all_backups[max_backups..-1] || []
    for unwanted_backup in unwanted_backups
      FileUtils.rm_rf(File.join(backup_base, unwanted_backup))
      puts "deleted #{unwanted_backup}" 
    end
    puts "Deleted #{unwanted_backups.length} backups, #{all_backups.length - unwanted_backups.length} backups available" 
  end
end


#rake db:backup
#rake db:backup DIR=APP_CONFIG[:backup_folder] Rails.env=production MAX=10

#cron job to do:
#"cd /app_dir && rake db:migrate"

#rake db:backup
#rake db:backup DIR=/home/parrs/db-backups Rails.env=production MAX=10

#cron job to do:
#"cd /app_dir && rake db:migrate"

# scp parrs@92.48.122.125:/home/parrs/db-backups/backup/2010-09-29_23-50-20/production_dump.sql.gz ~/Projects/parrs/
# mysql -u root -p PARRS_DEVELOPMENT < ~/Projects/parrs/production_dump.sql
# mysql -u root -p PARRS_DEVELOPMENT < db/production_dump.sql

# mysql -u root -p rubythere_development < db/production_dump.sql