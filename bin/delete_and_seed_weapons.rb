require "../config/environment"

Dynamoid.adapter.list_tables.each do |table|
  # Only delete tables in our namespace
  if table =~ /^#{Dynamoid::Config.namespace}/
    Dynamoid.adapter.delete_table(table) if table =~ /weapons/
  end
end

Dynamoid.adapter.list_tables.each do |table|
  # Only delete tables in our namespace
  pp table
end

Dynamoid.included_models.each(&:create_table)

require 'csv'
csv_data = CSV.read('/Users/jcafarelli/Downloads/weapons.csv', :headers => true, :header_converters => :symbol, :converters => :all)

csv_data = csv_data.to_a
headers = csv_data.shift
string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
items = string_data.map {|row| Hash[*headers.zip(row).flatten] }
items.each do |item|
  Weapon.new(item).save
  sleep 2
end

