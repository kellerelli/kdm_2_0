module Aws
  require "aws-sdk"
  #a init method to be used for initialisation when the rails application start
  def self.init
    @dynamo_table = false
    @dynamo_db = false

    if AWS_SETTINGS["aws_dynamo"]
      region = AWS_SETTINGS["aws_dynamo"]['region']
      access_key_id = AWS_SETTINGS["aws_dynamo"]['access_key_id']
      secret_access_key = AWS_SETTINGS["aws_dynamo"]['secret_access_key']
    else
      region = ENV.fetch('AWS_REGION') { 'us-east-1' }
      access_key_id = ENV.fetch('aws_access_key_id') { nil }
      secret_access_key = ENV.fetch('aws_secret_access_key') { nil }
    end

    namespace = "dynamoid_app_development"
    endpoint = 'http://localhost:8000'

    if Rails.env.production?
      namespace = "dynamoid_app_production"
      endpoint = "https://dynamodb.#{region}.amazonaws.com"
    end


    Aws.config.update({
                          region: region,
                          credentials: Aws::Credentials.new(access_key_id, secret_access_key),
                          endpoint: endpoint
                      })
    @dynamo_db = Aws::DynamoDB::Client.new

    Dynamoid.configure do |config|
      config.adapter = 'aws_sdk_v2' # This adapter establishes a connection to the DynamoDB servers using Amazon's own AWS gem.
      config.access_key = access_key_id
      config.secret_key = secret_access_key
      config.namespace = namespace # To namespace tables created by Dynamoid from other tables you might have. Set to nil to avoid namespacing.
      config.warn_on_scan = true # Output a warning to the logger when you perform a scan rather than a query on a table.
      config.read_capacity = 5 # Read capacity for your tables
      config.write_capacity = 5 # Write capacity for your tables
      config.endpoint = endpoint unless endpoint.nil?
    end

    Dynamoid.included_models.each(&:create_table)
  end


  def self.client
    @dynamo_db
  end
  #the method that save in aws database
end