require 'csv'
csv_data = CSV.read('/Users/jcafarelli/Downloads/Items.csv', :headers => true, :header_converters => :symbol, :converters => :all)

csv_data = csv_data.to_a
headers = csv_data.shift
string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
array_of_hashes = string_data.map {|row| Hash[*headers.zip(row).flatten] }