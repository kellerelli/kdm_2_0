# Load the Rails application.
require_relative 'application'

#load AWS settings and init
AWS_SETTINGS = YAML.load_file("#{Rails.root}/config/aws_dynamo.yml") if File.exist?("#{Rails.root}/config/aws_dynamo.yml")

# Initialize the Rails application.
Rails.application.initialize!
Aws.init

# module Dynamoid
#   module Adapter
#     def reconnect!
#       require "dynamoid/adapter_plugin/#{Dynamoid::Config.adapter}" #unless Dynamoid::Adapter.const_defined?(Dynamoid::Config.adapter.camelcase)
#       @adapter = Dynamoid::Adapter::AwsSdkV2
#       self.tables = benchmark('Cache Tables') {list_tables}
#     end
#   end
# end
