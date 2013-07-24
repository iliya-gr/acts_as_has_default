module ActiveRecord
  module Acts

    module Default
      extend ActiveSupport::Concern

      module ClassMethods

        # Configuration options are:
        # 
        # * +column+ - specifies the column name to use for keeping the default flag (default: +default+)
        # * +scope+  - restricts the scope of default model selection. Example: <tt>acts_as_has_default scope: :parent_id</tt>
        def acts_as_has_default(options = {})
          configuration = {column: 'default', scope: []}
          configuration.update(options) if options.is_a?(Hash)

          configuration[:scope] = [configuration[:scope]] if configuration[:scope].is_a? Symbol

          class_eval <<-RUBY, __FILE__, __LINE__ + 1

            def defaults_scope_conditions_for_#{configuration[:column]}
              scope = ::ActiveRecord::VERSION::MAJOR == 4 ? self.class.all : self.class.scoped
              %w(#{configuration[:scope].join(' ')}).each do |attr|
                scope = scope.where(attr.intern => self[attr.intern])
              end
              scope
            end

          RUBY

          class_eval <<-RUBY, __FILE__, __LINE__ + 1

            # Update column value
            def update_#{configuration[:column]}_as_default
              unless #{configuration[:column]}
                self.#{configuration[:column]} = defaults_scope_conditions_for_#{configuration[:column]}.where(self.class.arel_table[:id].not_eq(id)).empty?
              end

              true
            end

            # Set other models as non default if current model is default
            def invalidate_#{configuration[:column]}_as_default
              defaults_scope_conditions_for_#{configuration[:column]}.where(self.class.arel_table[:id].not_eq(id)).update_all(['`#{configuration[:column]}` = ?', false]) if #{configuration[:column]}
            end

            # Elect first model as default if there are no other default model
            def elect_#{configuration[:column]}_as_default
              unless defaults_scope_conditions_for_#{configuration[:column]}.where(self.class.arel_table[:id].not_eq(id)).empty?
                target = defaults_scope_conditions_for_#{configuration[:column]}.where(self.class.arel_table[:id].not_eq(id)).first
                target.update_attributes(#{configuration[:column]}: true) if target
              end
            end

          RUBY

          before_save   "update_#{configuration[:column]}_as_default".intern,     if: configuration[:if], unless: configuration[:unless]
          after_save    "invalidate_#{configuration[:column]}_as_default".intern, if: configuration[:if], unless: configuration[:unless]
          after_destroy "elect_#{configuration[:column]}_as_default".intern,      if: configuration[:if], unless: configuration[:unless]
        end

      end # ClassMethods
      
    end # Default

  end
end
