# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
host_drupalvm_dir = File.dirname(File.expand_path(__FILE__))


mdb_config = YAML.load_file("#{host_drupalvm_dir}/default.config.yml")

Vagrant.configure("2") do |config|
  config.vm.box = mdb_config['vagrant_box']
  config.vm.hostname = mdb_config['vagrant_hostname']
  config.vm.network :private_network, ip: mdb_config['vagrant_private_ip']
  
  config.vm.synced_folder "src/", "/var/www/", create: true
  
  config.vm.provision "shell" do |s|
    s.path = 'provisioners/bootstrap.sh'
    s.args = ["root"]
  end
  
  mdb_config['sites'].each do |site|
    config.vm.provision "shell" do |s|
      s.path = 'provisioners/generateSite.sh'
      s.args = [site['servername'], site['serveralias'], site['docroot']]
    end
  end
end