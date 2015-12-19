if !ENV['AWS_ID'].blank?
  CarrierWave.configure do |config|
    # config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ID'],
      aws_secret_access_key: ENV['AWS_SECRET'],
      region:                'eu-west-1'
    }
    config.fog_directory  = 'thunderbay'
    config.fog_public     = false
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  end
end
