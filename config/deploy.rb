# FIXME: common deployment stuff here, with a conditional load of the real
# recipe file, so that the real stuff can exist locally without being
# checked into the main repo.
 
capfile = File.expand_path("~/rubyvous/library/deploy.rb")
load(capfile) if File.exists?(capfile)