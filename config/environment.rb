# Load the Rails application.
require_relative 'application'

#load AWS settings and init
AWS_SETTINGS = YAML.load_file("#{Rails.root}/config/aws_dynamo.yml")

# Initialize the Rails application.
Rails.application.initialize!
Aws.init
