module Aws
  require "aws-sdk"
  #a init method to be used for initialisation when the rails application start
  def self.init
    @dynamo_table = false
    @dynamo_db = false
    if AWS_SETTINGS["aws_dynamo"]
      Aws.config.update({
                            region: AWS_SETTINGS["aws_dynamo"]['region'],
                            credentials: Aws::Credentials.new(AWS_SETTINGS["aws_dynamo"]['access_key_id'], AWS_SETTINGS["aws_dynamo"]['secret_access_key']),
                            endpoint: 'http://localhost:8000'
                        })
      @dynamo_db = Aws::DynamoDB::Client.new

      Dynamoid.configure do |config|
        config.adapter = 'aws_sdk_v2' # This adapter establishes a connection to the DynamoDB servers using Amazon's own AWS gem.
        config.access_key = AWS_SETTINGS["aws_dynamo"]['access_key_id']
        config.secret_key = AWS_SETTINGS["aws_dynamo"]['secret_access_key']
        config.namespace = "dynamoid_app_development" # To namespace tables created by Dynamoid from other tables you might have. Set to nil to avoid namespacing.
        config.warn_on_scan = true # Output a warning to the logger when you perform a scan rather than a query on a table.
        config.read_capacity = 5 # Read capacity for your tables
        config.write_capacity = 5 # Write capacity for your tables
        config.endpoint = 'http://localhost:8000' # [Optional]. If provided, it communicates with the DB listening at the endpoint. This is useful for testing with [Amazon Local DB] (http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Tools.DynamoDBLocal.html).
      end

      Dynamoid.included_models.each(&:create_table)
    end
  end

  def self.client
    @dynamo_db
  end
  #the method that save in aws database
end