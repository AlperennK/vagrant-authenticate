require 'vagrant/action'


module VagrantPlugins
  module Authenticate
    module Action
      class Base
        # Cleanup any shared folders before destroying the VM.

        # loading the datafile from disk.
        def self.setup
          Vagrant::Action::Builder.new.tap do |b|
            b.use Vagrant::Action::Builtin::EnvSet, authenticate: Env.new

            b.use Action::Authenticate

          end
        end


        def initialize(app, env)

          @app = app

          klass = self.class.name.downcase.split('::').last
          @logger = Log4r::Logger.new("vagrant::authenticate::#{klass}")
        end
      end
    end
  end
end
