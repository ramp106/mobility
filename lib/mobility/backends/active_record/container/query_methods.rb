require "mobility/backends/active_record/jsonb"

module Mobility
  module Backends
    class ActiveRecord::Container::QueryMethods < ActiveRecord::QueryMethods
      include ActiveRecord::PgQueryMethods
      attr_reader :column_name, :column

      def initialize(_attributes, options)
        super
        @column_name = options[:column_name]
        @column      = arel_table[@column_name]
      end

      private

      def contains_value(key, value, locale)
        build_infix(:'@>',
                    build_infix(:'->', column, quote(locale)),
                    quote({ key => value }.to_json))
      end

      def has_locale(key, locale)
        build_infix(:'?', column, quote(locale)).and(
          build_infix(:'?',
                      build_infix(:'->', column, quote(locale)),
                      quote(key)))
      end
    end
  end
end
