require 'pathname'
require 'vagrant/util/hash_with_indifferent_access'

module VagrantPlugins
  module Authenticate
    class Config < Vagrant.plugin("2", :config)
      MAYBE = Object.new.freeze


      # @return [Boolean]
      attr_accessor :enabled

      # The array of cookbook groups to exclusively install during provisioning.
      # @return [Array<Symbol>]
      attr_accessor :boxes

      def initialize
        super
        @enabled        = UNSET_VALUE

        @__finalized = false
      end

      def finalize!
        @enabled = MAYBE if @enabled == UNSET_VALUE

        @__finalized = true
      end

      #The plugin will present the user with a prompt to authenticate to bin.swissom.com, from which it will retrieve a token that will be exported as an environment variable
      #
      def validate(machine)
        #errors = _detected_errors
        #Check if boxes downloaded and set @enabled = false

        if @enabled || @enabled == MAYBE
        end

      end

      def to_hash
        raise "Must finalize first." if !@__finalized

        {
          enabled:        @enabled,
          boxes:          @boxes,
        }
      end

      def missing?(obj)
        obj.to_s.strip.empty?
      end
    end
  end
end
