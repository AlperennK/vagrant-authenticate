require 'vagrant/action'
require_relative 'action/authenticate'
require_relative 'env'

module VagrantPlugins
  module Authenticate
    class Plugin < Vagrant.plugin("2")
      # Require a particular version of Vagrant
      Vagrant.require_version(">= 1.5")

      name "authenticate"
      description <<-DESC
      Automatically pops up authentication prompt for artifactory access
      DESC

      config(:authenticate) do
        require_relative "config"
        Config
      end

      [:environment_plugins_loaded, :environment_load, :environment_unload, :machine_action_boot, :machine_action_config_validate,  :machine_action_destroy, :machine_action_halt, :machine_action_package, :machine_action_provision, :machine_action_read_state, :machine_action_reload, :machine_action_resume, :machine_action_run_command, :machine_action_ssh, :machine_action_suspend, :machine_action_sync_folders, :machine_action_up].each do |action|
        action_hook(:authenticate_provision, action) do |hook|
          hook.after(Vagrant::Action::Builtin::ConfigValidate, Action::Base.setup)
        end
      end



        action_hook(:authenticate, :machine_action_up) do |hook|
        hook.prepend(Action::Base.setup)
      end

      action_hook(:authenticate, :machine_action_reload) do |hook|
        hook.prepend(Action::Base.setup)
      end
    end

  end
end
