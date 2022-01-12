# Vagrant Authenticate Plugin

Vagrant Authenticate plugin will authenticate user if user don't have boxes in their environment in order to download them from artifactory.

## Installation

1. Install the latest version of [Vagrant](https://www.vagrantup.com/downloads.html)
2. Create gem file with 
  ```sh
  $ gem build vagrant-authenticate
  ```

3. Install the Vagrant Authenticate plugin:

  ```sh
  $ vagrant plugin install vagrant-authenticate
  ```

## Usage

If the Vagrant authenticate 

Here is an example Vagrantfile configuration section for Vagrant authenticate:

```ruby
Vagrant.configure("2") do |config|

  config.vagrant.plugins = ["vagrant-none-communicator", "vagrant-proxyconf", "vagrant-host-shell", "vagrant-authenticate"]

  config.proxy.http     = "http://server-proxy.corproot.net:8080"
  config.proxy.https    = "http://server-proxy.corproot.net:8080"
  config.proxy.no_proxy = "localhost,.swisscom.com,.corproot.net,.sharedtcs.net"

  config.trigger.before :up do |trigger|
    trigger.name = "Trigger authenticate"
    trigger.info = "Authenticate should run before vagrant up!!"
    config.authenticate.boxes=_boxes_to_download
    config.authenticate.enabled=true
  end
```

## Contributing

Thank you Joao Periera