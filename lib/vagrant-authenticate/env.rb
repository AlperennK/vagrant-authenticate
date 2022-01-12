require 'vagrant/ui'

module VagrantPlugins
  module Authenticate
    class Env
      # @return [String]
      attr_accessor :shelf

      def initialize
        @shelf = nil
      end
    end
  end
end
