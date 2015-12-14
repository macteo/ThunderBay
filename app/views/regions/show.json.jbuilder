json.extract! @region, :id, :identifier, :uuid, :major, :minor, :lat, :lon, :radius, :venue_id, :note, :behavior, :created_at, :updated_at
if @region.enter_trigger_id
  json.enter_trigger = @region.enter_trigger.to_json
end
if @region.enter_trigger_id
  json.enter_trigger @region.enter_trigger
end
if @region.exit_trigger_id
  json.exit_trigger @region.exit_trigger
end
if @region.range_trigger_id
  json.range_trigger @region.range_trigger
end
