class DynamoTable
  require 'json'
  attr_accessor :client

  def self.client
    Aws.client
  end

  def self.table
    'Default'
  end

  def self.index
    params = {
        table_name: self.table
    }
    return self.client.scan(params).items
  end

end