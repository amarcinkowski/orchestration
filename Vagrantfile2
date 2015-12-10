VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
  # config.vm.network "public_network"
  # config.ssh.forward_agent = true
  config.vm.synced_folder ".", "/vagrant_data"

  config.vm.provider "docker" do |d|
    d.build_dir = "."
    d.has_ssh = true
    d.volumes = ["/vagrant:/vagrant"]
    d.ports = ["80:80"]
    args = "-v /vagrant_data:/vagrant_data"
  end
  config.ssh.port = 22
end
