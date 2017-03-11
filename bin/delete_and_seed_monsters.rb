require "../config/environment"

pp "tables before delete"
Dynamoid.adapter.list_tables.each do |table|
  # Only delete tables in our namespace
  pp table
end

Dynamoid.adapter.list_tables.each do |table|
  # Only delete tables in our namespace
  if table =~ /^#{Dynamoid::Config.namespace}/
    sleep 2
    Dynamoid.adapter.delete_table(table) if table =~ /monsters/
    sleep 2
    Dynamoid.adapter.delete_table(table) if table =~ /levels/
  end
end
sleep 2
pp "table after delete"
Dynamoid.adapter.list_tables.each do |table|
  # Only delete tables in our namespace
  pp table
end
sleep 2
Dynamoid.included_models.each(&:create_table)


require 'csv'
csv_data = CSV.read('/Users/jcafarelli/Downloads/Monsters.csv', :headers => true, :header_converters => :symbol, :converters => :all)

csv_data = csv_data.to_a
headers = csv_data.shift
string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
monsters = string_data.map {|row| Hash[*headers.zip(row).flatten] }
monsters.each do |monster|
  pp "Finding monster"
  sleep 2
  monster_found = begin
    Monster.where(name: monster[:name]).all.first
  rescue
    nil
  end

  if monster_found.nil?
    pp "Monster not found, creating"
    monster_found = Monster.new({name: monster[:name]})
    monster_found.save
    sleep 5
  end
  pp "creating level"
  level = monster_found.levels.create(monster)
  sleep 2
  level.save
end

