require "forwardable"

module Capistrano
  module DSL
    module Env
      extend Forwardable
      def_delegators :env,
                     :configure_backend, :fetch, :set, :set_if_empty, :delete,
                     :ask, :role, :server, :primary, :validate, :append, :remove

      def is_question?(key)
        env.is_question?(key)
      end

      def any?(key)
        env.any?(key)
      end

      def roles(*names)
        env.roles_for(names.flatten)
      end

      def role_properties(*names, &block)
        env.role_properties_for(names, &block)
      end

      def release_roles(*names)
        if names.last.is_a? Hash
          names.last.merge!(:exclude => :no_release)
        else
          names << { :exclude => :no_release }
        end
        roles(*names)
      end

      def env
        Configuration.env
      end
    end
  end
end
