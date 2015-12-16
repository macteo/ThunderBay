json.array!(@triggers) do |trigger|
  json.extract! trigger, :id, :type, :url, :name, :payload
  json.url trigger_url(trigger, format: :json)
end
