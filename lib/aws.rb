module Aws
  require "aws-sdk"
  #a init method to be used for initialisation when the rails application start
  def self.init
    @dynamo_table = false
    @dynamo_db = false
    if AWS_SETTINGS["aws_dynamo"]
      Aws.config.update({
                            region: AWS_SETTINGS["aws_dynamo"]['region'],
                            credentials: Aws::Credentials.new(AWS_SETTINGS["aws_dynamo"]['access_key_id'], AWS_SETTINGS["aws_dynamo"]['secret_access_key'])
                        })
      @dynamo_db = Aws::DynamoDB::Client.new
    end
  end

  def self.client
    @dynamo_db
  end
  #the method that save in aws database
end