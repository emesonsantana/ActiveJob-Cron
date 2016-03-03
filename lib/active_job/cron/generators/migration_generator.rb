require "rails/generators"
require 'rails/generators/migration'

module ActiveJob
  module Cron
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.source_root
        File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def self.next_migration_number(dirname)
        next_migration_number = current_migration_number(dirname) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end

      def create_migration_file
        migration_template 'create_active_job_locks.rb', 'db/migrate/create_active_job_locks.rb'
      end
    end
  end
end
