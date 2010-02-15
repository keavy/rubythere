# FIXME: common deployment stuff here, with a conditional load of the real
# recipe file, so that the real stuff can exist locally without being
# checked into the main repo.
 
capfile = File.expand_path("~/Sites/rubyvous/library/deploy.rb")
load(capfile) if File.exists?(capfile)

Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
