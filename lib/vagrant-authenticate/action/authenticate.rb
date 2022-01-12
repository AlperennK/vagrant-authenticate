require_relative 'base'
require 'json'

module VagrantPlugins
  module Authenticate
    module Action
      class Authenticate < Base
        def call(env)

          authenticate=false


          unless env[:machine].config.authenticate.to_hash[:enabled]
            @logger.info "Authenticate disabled, skipping"
            return @app.call(env)
          end



          vagrantfile_path=env[:env].local_data_path.to_s.gsub(".vagrant", "Vagrantfile")


          # Setup the config loader
          config_loader = Vagrant::Config::Loader.new(
            Vagrant::Config::VERSIONS, Vagrant::Config::VERSIONS_ORDER)

          # Add the path to my_vagrantfile to the config loader
          config_loader.set(:root, vagrantfile_path)

          # Create the Vagrantfile object. In this case we only setup :root as
          # a config source so we just want to load that one.
          v = Vagrant::Vagrantfile.new(config_loader, [:root])


          for machine_name in v.machine_names
            machine_config=v.machine_config(machine_name, env[:env].default_provider, env[:box_collection])

            authenticate=machine_config[:box].nil?
            if authenticate
              puts "Box not found please authenticate : "
              puts ENV["WSL_INI"]
              if ENV["WSL_INI"].nil?
                if ENV["USERNAME"].nil?
                  puts "Enter your username: "
                  ENV["USERNAME"] = STDIN.gets.chomp
                end
                ENV["PASSWORD"] = STDIN.getpass("Password:")
                ENV["WSL_INI"]="true"
              end

              # Add retry for
              uri = URI.parse($vagrant_server_base_url + "auth")
              request = Net::HTTP::Get.new(uri)
              request.basic_auth(ENV["USERNAME"], ENV["PASSWORD"])
              req_options = {
                use_ssl: uri.scheme == "https",
              }
              response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
                http.request(request)
              end


              if response.code.to_i == 200
                ENV["ATLAS_TOKEN"] = response.body
              else
                puts 'response code from artifactory for password retrieval: ' + response.code
                abort ('aborting ...' )
              end

              ENV["VAGRANT_SERVER_URL"] = $vagrant_repo_url
              ENV["VAGRANT_SERVER_ACCESS_TOKEN_BY_URL"] = "1"

            end
          end

        end
      end
    end
  end
end
