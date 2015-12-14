json.extract! @region, :id, :identifier, :uuid, :major, :minor, :lat, :lon, :radius, :venue_id, :note, :behavior, :created_at, :updated_at
if @region.enter_trigger_id
  json.enter_trigger @region.enter
end
if @region.exit_trigger_id
  json.exit_trigger @region.exit
end
if @region.range_trigger_id
  json.range_trigger @region.range
end
