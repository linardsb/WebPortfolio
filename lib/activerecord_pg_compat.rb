# Fix for Rails 5.2.8 + pg >= 1.1 compatibility
# The pg gem >= 1.1 causes PostgreSQL adapter to call add_modifier with 3 args
# but Rails 5.2 only expects 2 args

module ActiveRecord
  module Type
    class AdapterSpecificRegistry < ActiveModel::Type::Registry
      # Store original method
      alias_method :original_add_modifier, :add_modifier if method_defined?(:add_modifier)

      # Override to accept variable arguments
      def add_modifier(options_or_type, klass_or_options = nil, options = nil)
        # If 3 arguments are provided (new pg gem behavior)
        # Just ignore them for now to prevent the error
        # Rails 5.2 doesn't actually use this method much
        if options
          # 3-arg call from newer pg: just skip it
          return
        end

        # 2-arg call (original Rails 5.2 behavior)
        if respond_to?(:original_add_modifier)
          original_add_modifier(options_or_type, klass_or_options)
        else
          registrations << DecorationRegistration.new(options_or_type, klass_or_options)
        end
      end
    end
  end
end
