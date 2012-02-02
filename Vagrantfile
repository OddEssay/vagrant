Vagrant::Config.run do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "lucid32"

  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  
  config.vm.boot_mode = :gui

  # config.vm.network "33.33.33.10"

  config.vm.forward_port 80, 4568 

  config.vm.share_folder "www", "/www", "../www"

   config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "vm.box.pp"
     puppet.module_path = "modules"
   end
end