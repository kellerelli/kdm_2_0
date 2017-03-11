require "../config/environment"

Dynamoid.adapter.list_tables.each do |table|
  # Only delete tables in our namespace
  if table =~ /^#{Dynamoid::Config.namespace}/
    Dynamoid.adapter.delete_table(table) if table =~ /items/
  end
end

Dynamoid.adapter.list_tables.each do |table|
  # Only delete tables in our namespace
  pp table
end

Dynamoid.included_models.each(&:create_table)

Dynamoid.adapter.list_tables.each do |table|
  # Only delete tables in our namespace
  pp table
end

# require 'csv'
# csv_data = CSV.read('/Users/jcafarelli/Downloads/Items.csv', :headers => true, :header_converters => :symbol, :converters => :all)
#
# csv_data = csv_data.to_a
# headers = csv_data.shift
# string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
# items = string_data.map {|row| Hash[*headers.zip(row).flatten] }
# items.each do |item|
#   Item.new(item).save
# end

